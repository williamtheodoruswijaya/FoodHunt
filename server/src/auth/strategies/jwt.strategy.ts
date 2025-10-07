import { PassportStrategy } from '@nestjs/passport';
import { User } from '../../user/user.entity';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { Inject, Injectable, UnauthorizedException } from '@nestjs/common';
import { UserRepository } from '../../user/interfaces/iuser.repository';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    @Inject('UserRepository') private readonly userRepository: UserRepository,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_SECRET,
    });
  }

  // NOTES: fungsi ini akan menempelkan user yang di return di objek Request bawaan dari NestJS
  async validate(payload: { sub: number; username: string }): Promise<User> {
    // 'sub' adalah ID user yang kita masukkan saat membuat token di AuthService
    const user = await this.userRepository.findById(payload.sub);
    if (!user) {
      throw new UnauthorizedException();
    }

    // Objek yang di-return di sini akan ditambahkan ke object Request
    return user;
  }
}
