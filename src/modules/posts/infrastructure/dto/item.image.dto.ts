import { IsNotEmpty } from 'class-validator';

export class ItemImage {
  id: number;

  itemId: number;

  @IsNotEmpty({ message: 'Please add valid URL for the image!' })
  link: string;
}
