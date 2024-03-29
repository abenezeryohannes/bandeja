import { ForbiddenException, Inject, Injectable } from '@nestjs/common';
import { PostDto } from '../../infrastructure/dto/post.dto';
import { Post } from '../entities/post.entity';
import { join } from 'path';
import { PostGroup } from '../entities/post.group.entity';
import { PostImage } from '../entities/post.image.entity';
import {
  POST_IMAGE_REPOSITORY,
  POST_REPOSITORY,
} from '../../../../core/constants';
import { User } from '../../../users/domain/entities/user.entity';
import { Util } from '../../../../core/utils/util';
import { ROLE } from '../../../users/infrastructure/dto/user.dto';
import { PostGroupEditDto } from '../../infrastructure/dto/post.group.edit.dto';
import { PostEditDto } from '../../infrastructure/dto/post.edit.dto';

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
      order: [['id', 'DESC']],
    });
  }

  async findAll(query: any): Promise<Post[]> {
    const condition = {};
    if (query.addressId != null && query.addressId != '')
      condition['addressId'] = Number.parseInt(query.addressId);
    if (query.postGroupId != null && query.postGroupId != '')
      condition['postGroupId'] = Number.parseInt(query.postGroupId);

    return this.postRepository.findAll({
      where: condition,
      include: [PostImage, User, PostGroup],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      order: [['id', 'DESC']],
    });
  }

  async featured(user: User, query: any): Promise<Post[]> {
    return await this.postRepository.findAll({
      where: { enabled: true, featured: true },
      include: [{ model: User }, { model: PostImage }, { model: PostGroup }],
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

  async edit(request: any, body: PostEditDto): Promise<Post> {
    const post = await this.postRepository.findByPk(body.id);

    if (post == null) throw Error('No Ad found with this id!');

    if (body.enabled != null) post.enabled = body.enabled;
    if (body.desc != null) post.desc = body.desc;
    if (body.featured != null) post.featured = body.featured;
    if (body.offer != null) post.offer = body.offer;
    if (body.phoneNumber != null) post.phoneNumber = body.phoneNumber;
    if (body.postGroupId != null) post.postGroupId = body.postGroupId;
    if (body.price != null) post.price = body.price;
    if (body.whatsApp != null) post.whatsApp = body.whatsApp;

    const ops = [];
    if (request.files != null && request.files.length > 0) {
      await this.postImageRepository.destroy({
        where: {
          postId: body.id,
        },
      });
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
    }
    await Promise.all(ops);

    return await post.save({ transaction: request.transaction });
  }

  async delete(id: number): Promise<boolean> {
    if (id == null) throw Error('No identifier provided to delete!');

    const post = await this.postRepository.findByPk(id, {
      include: [PostImage],
    });

    if (post.PostImages != null && post.PostImages.length > 0) {
      await this.postImageRepository.destroy({ where: { postId: post.id } });
    }
    await post.destroy();
    return true;
  }

  async deleteAll(ids: number[]): Promise<any[]> {
    if (ids == null) throw Error('No identifier provided to delete!');
    const ops = [];
    for (let i = 0; i < ids.length; i++) {
      ops.push(this.delete(ids[i]));
    }
    return await Promise.all(ops);
  }
}
