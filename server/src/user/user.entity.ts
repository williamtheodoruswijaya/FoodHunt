import { UserProps } from './interfaces/iuser.entity';

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

  // Getter (Setter-nya ada di Builder)
  public getUserId(): number {
    return this.userId;
  }

  public getUsername(): string {
    return this.username;
  }

  public getName(): string {
    return this.name;
  }

  public getEmail(): string {
    return this.email;
  }

  public getPassword(): string | null {
    return this.password;
  }

  public getBio(): string {
    return this.bio;
  }

  public getPoints(): number {
    return this.points;
  }

  public getRole(): ROLE {
    return this.roles;
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
