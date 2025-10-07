import { AuthGuard, PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { Request } from 'express';
import { Injectable, UnauthorizedException } from '@nestjs/common';

@Injectable()
export class RefreshTokenStrategy extends PassportStrategy(
  Strategy,
  'jwt-refresh',
) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_REFRESH_SECRET,
      passReqToCallback: true,
    });
  }

  validate(req: Request, payload: any) {
    const authHeader = req.get('Authorization');
    if (!authHeader) {
      throw new UnauthorizedException('Authorization header is required!');
    }

    const refreshToken = authHeader.replace('Bearer ', '').trim();
    if (!refreshToken) {
      throw new UnauthorizedException('Refresh token is required!');
    }

    return { ...payload, refreshToken };
  }
}

@Injectable()
export class RefreshTokenGuard extends AuthGuard('jwt-refresh') {}
