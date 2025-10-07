import { Body, Controller, Inject, Post } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { WebResponse } from '../common/model/web.response';
import { CreateUserDto, UserResponseDto } from '../user/dto/create-user.dto';
import { AuthUserDto, AuthUserResponseDto } from './dto/auth-user.dto';
import { AuthService } from './interfaces/iauth.service';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(
    @Inject('AuthService') private readonly authService: AuthService,
  ) {}

  @Post('register')
  @ApiOperation({ summary: 'Register a user' })
  @ApiResponse({ status: 409, description: 'User Already Exists' })
  @ApiResponse({
    status: 201,
    description: 'User Registered Successfully',
    type: WebResponse<UserResponseDto>,
  })
  async register(
    @Body() registerDto: CreateUserDto,
  ): Promise<WebResponse<UserResponseDto>> {
    const user = await this.authService.register(registerDto);
    return {
      data: user,
    };
  }

  @Post('login')
  @ApiOperation({ summary: 'Login a user' })
  @ApiResponse({ status: 401, description: 'Incorrect authentication' })
  @ApiResponse({
    status: 200,
    description: 'User Login Successfully',
    type: WebResponse<AuthUserResponseDto>,
  })
  async login(
    @Body() loginDto: AuthUserDto,
  ): Promise<WebResponse<AuthUserResponseDto>> {
    const tokens = await this.authService.login(loginDto);
    return {
      data: tokens,
    };
  }
}
