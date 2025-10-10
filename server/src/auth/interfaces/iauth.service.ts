import { AuthUserDto, AuthUserResponseDto } from '../dto/auth-user.dto';
import { CreateUserDto, UserResponseDto } from '../../user/dto/create-user.dto';

export interface AuthService {
  register(req: CreateUserDto, owner?: boolean): Promise<UserResponseDto>;
  login(req: AuthUserDto): Promise<AuthUserResponseDto>;
}
