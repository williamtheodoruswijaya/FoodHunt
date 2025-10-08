import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import {
  Controller,
  Get,
  Inject,
  Param,
  ParseIntPipe,
  Query,
  UseGuards,
} from '@nestjs/common';
import { WebResponse } from '../common/model/web.response';
import { JwtAuthGuard } from '../common/guards/jwt.guards';
import { SearchUserDto } from './dto/search-user.dto';
import { UserResponseDto } from './dto/create-user.dto';
import { UserService } from './interfaces/iuser.service';

@ApiTags('User')
@Controller('users')
export class UserController {
  constructor(
    @Inject('UserService') private readonly userService: UserService,
  ) {}

  // users/search?username=johndoe
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Get('search')
  @ApiOperation({ summary: 'Get user with username or email' })
  @ApiResponse({ status: 400, description: 'User does not exist' })
  @ApiResponse({
    status: 200,
    description: 'User found',
    type: WebResponse<UserResponseDto>,
  })
  async searchUser(
    @Query() searchUserDto: SearchUserDto,
  ): Promise<WebResponse<UserResponseDto>> {
    const user = await this.userService.search(searchUserDto);
    return {
      data: user,
    };
  }

  // users/3
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Get(':id')
  @ApiOperation({ summary: 'Get user with user id' })
  @ApiResponse({ status: 400, description: 'User does not exist' })
  @ApiResponse({
    status: 200,
    description: 'User found',
    type: WebResponse<UserResponseDto>,
  })
  async findById(
    @Param('id', ParseIntPipe) id: number,
  ): Promise<WebResponse<UserResponseDto>> {
    const user = await this.userService.findById(id);
    return {
      data: user,
    };
  }
}
