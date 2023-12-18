import { Module } from '@nestjs/common';
import { SystemService } from './system.service';
import { SystemController } from './system.controller';
import { SshService } from 'src/ssh/ssh.service';

@Module({
  controllers: [SystemController],
  providers: [SystemService, SshService],
  exports: [SystemService],
})
export class SystemModule {}
