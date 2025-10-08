import { UserResponseDto } from '../dto/create-user.dto';
import { SearchUserDto } from '../dto/search-user.dto';

export interface UserService {
  search(searchDto: SearchUserDto): Promise<UserResponseDto>;
  findById(userId: number): Promise<UserResponseDto>;
  findByUsername(username: string): Promise<UserResponseDto>;
  findByEmail(email: string): Promise<UserResponseDto>;
}
