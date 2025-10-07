import { User } from '../../user/user.entity';
import { Prisma } from '@prisma/client';

export interface AuthRepository {
  save(user: User, tx?: Prisma.TransactionClient): Promise<User>;
}
