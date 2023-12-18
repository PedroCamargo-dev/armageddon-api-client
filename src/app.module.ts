import { Module } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { SystemModule } from './system/system.module';
import { PrismaModule } from './prisma/prisma.module';
import { SshModule } from './ssh/ssh.module';
import { SshService } from './ssh/ssh.service';

@Module({
  imports: [SystemModule, PrismaModule, SshModule],
  controllers: [],
  providers: [PrismaService, SshService],
})
export class AppModule {}
