import { ROLE } from '../user.entity';

export interface UserProps {
  userId?: number;
  username: string;
  name: string;
  email: string;
  password?: string | null;
  googleId?: string | null;
  facebookId?: string | null;
  bio?: string;
  points?: number;
  roles?: ROLE;
  createdAt?: Date;
  updatedAt?: Date;
}
