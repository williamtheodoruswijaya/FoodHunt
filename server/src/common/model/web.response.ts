import { Paging } from './paging.model';

export class WebResponse<T> {
  data?: T;
  errors?: string;
  paging?: Paging;
}
