import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class SearchQueryDto {
  @ApiProperty({
    description: 'Keyword untuk mencari nama/deskripsi/alamat',
    required: true,
  })
  @IsString()
  keyword: string;
}
