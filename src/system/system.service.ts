import { Injectable } from '@nestjs/common';
import { CreateSystemDto } from './dto/create-system.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { SshService } from 'src/ssh/ssh.service';
import * as fs from 'fs';
import { io, Socket } from 'socket.io-client';

@Injectable()
export class SystemService {
  private socket: Socket;
  constructor(
    private prisma: PrismaService,
    private sshClient: SshService,
  ) {}

  private connectSocket(server) {
    this.socket = io(server);
    return this.socket;
  }

  async create(createSystemDto: CreateSystemDto) {
    const createSystem = this.prisma.system.create({
      data: createSystemDto,
    });

    if (createSystem) {
      console.log('System created successfully');
      await this.sshClient.exec(
        createSystemDto,
        fs.readFileSync('./command.txt', 'utf8'),
        true,
      );
    }

    return createSystem;
  }

  async startAPI(id: number) {
    const system = await this.prisma.system.findUnique({
      where: { id: id },
    });

    if (system) {
      await this.sshClient.exec(
        system,
        'cd $HOME/project-armageddon/armageddon-api && npm install && npm run build && npm run start:prod',
        false,
      );
    }

    return system;
  }

  findAll() {
    const allSystems = this.prisma.system.findMany();
    if (allSystems) {
      console.log('All systems fetched successfully');
    }
    return allSystems;
  }

  async metricsSystems(server) {
    const searchServers = await this.findByIds(server.ids);
    for (let i = 0; i < searchServers.length; i++) {
      const socket = io(
        `http://${searchServers[i].IP}:${searchServers[i].portSocket}`,
      );
      socket.on('osInfo', (message) => {
        console.log('Received message:', message);
      });
    }

    return 'asdasds';
  }

  async findByIds(ids: number[]) {
    const systems = await this.prisma.system.findMany({
      where: {
        id: {
          in: ids,
        },
      },
    });

    return systems;
  }

  remove(id: number) {
    const deleteSystem = this.prisma.system.delete({
      where: { id: id },
    });

    if (deleteSystem) {
      console.log('System deleted successfully');
    }
    return deleteSystem;
  }
}
