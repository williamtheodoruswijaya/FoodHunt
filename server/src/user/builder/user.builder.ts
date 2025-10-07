import { ROLE, User } from 'src/user/user.entity';
import { UserProps } from '../interfaces/iuser.entity';

export class UserBuilder {
  // Data yang sedang dibuild akan disimpan disini (anggap aja ini variable temp buat builder design pattern)
  private props: Partial<UserProps> = {};

  // Constructor ini tuh anggep aja kayak atribut yang not nullable di objek kita
  constructor(username: string, email: string) {
    this.props.username = username;
    this.props.email = email;

    // default value buat atribut yang wajib
    this.props.roles = ROLE.USER;
    this.props.points = 0;
  }

  // setter (chaining method for builder design pattern)
  public setUserId(userId: number) {
    this.props.userId = userId;
    return this;
  }

  public setName(name: string): this {
    this.props.name = name;
    return this;
  }

  public setBio(bio: string): this {
    this.props.bio = bio;
    return this;
  }

  public setPassword(password: string): this {
    this.props.password = password;
    return this;
  }

  public setGoogleId(googleId: string): this {
    this.props.googleId = googleId;
    return this;
  }

  public setRole(role: ROLE): this {
    this.props.roles = role;
    return this;
  }

  public setPoints(points: number): this {
    this.props.points = points;
    return this;
  }

  // build function
  public build(): User {
    if (!this.props.password && !this.props.googleId) {
      console.warn('Warning: Creating a user without a password.');
    }
    return new User(this.props);
  }
}
