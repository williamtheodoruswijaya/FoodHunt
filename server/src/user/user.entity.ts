import { UserProps } from './interface/iuser.entity';

export enum ROLE {
  USER = 'User',
  RESTAURANT = 'Restaurant',
}

export class User {
  private userId: number;
  private username: string;
  private name: string;
  private email: string;
  private password: string | null;
  private bio: string;
  private points: number;
  private roles: ROLE;
  private createdAt: Date;
  private updatedAt: Date;

  // OAuth
  private googleId: string | null;
  private facebookId: string | null;

  constructor(partial: Partial<UserProps>) {
    Object.assign(this, partial);
  }

  // Business Logic
  public isRestaurantOwner(): boolean {
    return this.roles === ROLE.RESTAURANT;
  }

  public hasPassword(): boolean {
    return this.password !== null && this.password !== undefined;
  }

  public addPoints(amount: number): void {
    if (amount > 0) {
      this.points += amount;
    }
  }
}
