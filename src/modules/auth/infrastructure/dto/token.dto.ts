export class TokenDto {
  readonly id: BigInteger;
  readonly userId: BigInteger;
  readonly role: string;
  readonly token: string;
  readonly until: Date;
}
