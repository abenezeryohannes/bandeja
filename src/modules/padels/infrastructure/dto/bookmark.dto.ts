import { IsNotEmpty } from 'class-validator';

export class BookmarkDto {
  @IsNotEmpty({
    message: 'No padel identifier presented to perform this task.',
  })
  readonly id: number;
}
