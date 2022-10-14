import { ForbiddenException, Inject, Injectable } from '@nestjs/common';
import { POST_IMAGE_REPOSITORY, POST_REPOSITORY } from 'src/core/constants';
import { Util } from 'src/core/utils/util';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { PostDto } from '../../infrastructure/dto/post.dto';
import { Post } from '../entities/post.entity';
import { join } from 'path';
import { PostGroup } from '../entities/post.group.entity';
import { PostImage } from '../entities/post.image.entity';
import { ROLE } from 'src/modules/users/infrastructure/dto/user.dto';

@Injectable()
export class PostsService {
  constructor(
    @Inject(POST_REPOSITORY)
    private readonly postRepository: typeof Post,

    @Inject(POST_IMAGE_REPOSITORY)
    private readonly postImageRepository: typeof PostImage,
  ) {}

  async findAllMine(user: User, query: any): Promise<Post[]> {
    const condition = { userId: user.id };

    return this.postRepository.findAll({
      where: condition,
      include: [PostImage, User, PostGroup],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async findAll(query: any): Promise<Post[]> {
    const condition =
      query.addressId == null || query.addressId == ''
        ? {}
        : { addressId: Number.parseInt(query.addressId) };

    return this.postRepository.findAll({
      where: condition,
      include: [PostImage, User, PostGroup],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async featured(user: User, query: any): Promise<Post[]> {
    return await this.postRepository.findAll({
      where: { enabled: true, featured: true },
      include: [{ model: User, include: [] }, { model: PostGroup }],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      // order: [['distance', 'asc']],
    });
  }

  async create(request: any, postDto: PostDto): Promise<Post> {
    let post = this.postRepository.build({
      userId: request.user.id,
      desc: postDto.desc,
      postGroupId: postDto.postGroupId,
      price: postDto.price,
    });
    if (postDto.offer != null) post.offer = postDto.offer;
    if (postDto.desc != null) post.desc = postDto.desc;
    if (postDto.whatsApp != null) post.whatsApp = postDto.whatsApp;
    if (postDto.phoneNumber != null) post.phoneNumber = postDto.phoneNumber;

    post = await post.save({ transaction: request.transaction });
    post.setDataValue(
      'postGroupId',
      Number.parseInt(post.getDataValue('postGroupId')),
    );
    const ops = [];
    if (request.files != null && request.files.length > 0)
      for (let i = 0; i < request.files.length; i++) {
        ops.push(
          this.postImageRepository.create(
            {
              postId: post.id,
              img: join('public', request.files[i].filename),
            },
            { transaction: request.transaction },
          ),
        );
      }
    await Promise.all(ops);
    return post;
  }

  async destroy(id: number, request: any): Promise<number> {
    const post = await this.postRepository.findByPk(id);
    if (post.userId != request.user.id && request.token.role != ROLE.ADMIN) {
      throw new ForbiddenException('You can only delete your own Ads.');
    }
    await this.postImageRepository.destroy({ where: { postId: id } });
    return await this.postRepository.destroy({ where: { id: id } });
  }
}
