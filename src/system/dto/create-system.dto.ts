export class CreateSystemDto {
  name: string;
  description: string;
  username: string;
  password: string;
  IP: string;
  portSSH: number;
  portSocket: number;
  status: string;
}
