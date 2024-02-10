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

  async create(createSystemDto: CreateSystemDto) {
    const createSystem = await this.prisma.system.create({
      data: createSystemDto,
    });

    if (createSystem) {
      console.log('System created successfully');
      await this.sshClient.exec(
        createSystemDto,
        process.env.INSTALL_SCRIPT,
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

  async findAll() {
    const allSystems = await this.prisma.system.findMany();

    if (allSystems.length === 0) {
      return 'Nenhum sistema localizado';
    }
    if (allSystems) {
      return allSystems;
    }
  }

  async findAllSystemInfo() {
    const allSystems = this.prisma.system.findMany({
      select: {
        id: true,
        name: true,
        CPU: {
          select: {
            currentLoad: true,
          },
        },
        memories: {
          select: {
            used: true,
          },
        },
        NetworkInterfaceData: {
          select: {
            rx_sec: true,
            tx_sec: true,
          },
        },
      },
    });

    return this.toObject(await allSystems);
  }

  async metricsSystems(server) {
    const searchServers = await this.findByIds(server.ids);

    for (let i = 0; i < searchServers.length; i++) {
      this.socket = io(
        `http://${searchServers[i].IP}:${searchServers[i].portSocket}`,
      );

      server.datas.forEach(async (data) => {
        this.socket.on(data, async (res) => {
          if (data === 'Memory') {
            const existingMemory = await this.prisma.memory.findFirst({
              where: {
                systemId: searchServers[i].id,
              },
            });

            if (existingMemory) {
              const updatedMemory = await this.prisma.memory.update({
                where: {
                  id: existingMemory.id,
                },
                data: res,
              });

              return { ...updatedMemory };
            } else {
              const newMemory = await this.prisma.memory.create({
                data: {
                  system: {
                    connect: {
                      id: searchServers[i].id,
                    },
                  },
                  ...res,
                },
              });

              return { ...newMemory };
            }
          } else if (data === 'CPU') {
            const existingCPU = await this.prisma.cPU.findFirst({
              where: {
                systemId: searchServers[i].id,
              },
            });

            if (existingCPU) {
              const updatedCPU = await this.prisma.cPU.update({
                where: {
                  id: existingCPU.id,
                },
                data: {
                  manufacturer: res.manufacturer,
                  brand: res.brand,
                  vendor: res.vendor,
                  family: res.family,
                  model: res.model,
                  stepping: res.stepping,
                  revision: res.revision,
                  voltage: res.voltage,
                  speed: res.speed,
                  speedMin: res.speedMin,
                  speedMax: res.speedMax,
                  governor: res.governor,
                  cores: res.cores,
                  physicalCores: res.physicalCores,
                  performanceCores: res.performanceCores,
                  efficiencyCores: res.efficiencyCores,
                  processors: res.processors,
                  socket: res.socket,
                  flags: res.flags,
                  virtualization: res.virtualization,
                  avgLoad: res.avgLoad,
                  currentLoad: res.currentLoad,
                  currentLoadUser: res.currentLoadUser,
                  currentLoadSystem: res.currentLoadSystem,
                  currentLoadNice: res.currentLoadNice,
                  currentLoadIdle: res.currentLoadIdle,
                  currentLoadIrq: res.currentLoadIrq,
                  currentLoadSteal: res.currentLoadSteal,
                  currentLoadGuest: res.currentLoadGuest,
                  rawCurrentLoad: res.rawCurrentLoad,
                  rawCurrentLoadUser: res.rawCurrentLoadUser,
                  rawCurrentLoadSystem: res.rawCurrentLoadSystem,
                  rawCurrentLoadNice: res.rawCurrentLoadNice,
                  rawCurrentLoadIdle: res.rawCurrentLoadIdle,
                  rawCurrentLoadIrq: res.rawCurrentLoadIrq,
                  rawCurrentLoadSteal: res.rawCurrentLoadSteal,
                  rawCurrentLoadGuest: res.rawCurrentLoadGuest,
                },
              });

              return { ...updatedCPU };
            } else {
              const newCPU = await this.prisma.cPU.create({
                data: {
                  system: {
                    connect: {
                      id: searchServers[i].id,
                    },
                  },
                  manufacturer: res.manufacturer,
                  brand: res.brand,
                  vendor: res.vendor,
                  family: res.family,
                  model: res.model,
                  stepping: res.stepping,
                  revision: res.revision,
                  voltage: res.voltage,
                  speed: res.speed,
                  speedMin: res.speedMin,
                  speedMax: res.speedMax,
                  governor: res.governor,
                  cores: res.cores,
                  physicalCores: res.physicalCores,
                  performanceCores: res.performanceCores,
                  efficiencyCores: res.efficiencyCores,
                  processors: res.processors,
                  socket: res.socket,
                  flags: res.flags,
                  virtualization: res.virtualization,
                  avgLoad: res.avgLoad,
                  currentLoad: res.currentLoad,
                  currentLoadUser: res.currentLoadUser,
                  currentLoadSystem: res.currentLoadSystem,
                  currentLoadNice: res.currentLoadNice,
                  currentLoadIdle: res.currentLoadIdle,
                  currentLoadIrq: res.currentLoadIrq,
                  currentLoadSteal: res.currentLoadSteal,
                  currentLoadGuest: res.currentLoadGuest,
                  rawCurrentLoad: res.rawCurrentLoad,
                  rawCurrentLoadUser: res.rawCurrentLoadUser,
                  rawCurrentLoadSystem: res.rawCurrentLoadSystem,
                  rawCurrentLoadNice: res.rawCurrentLoadNice,
                  rawCurrentLoadIdle: res.rawCurrentLoadIdle,
                  rawCurrentLoadIrq: res.rawCurrentLoadIrq,
                  rawCurrentLoadSteal: res.rawCurrentLoadSteal,
                  rawCurrentLoadGuest: res.rawCurrentLoadGuest,
                },
              });

              return { ...newCPU };
            }
          } else if (data === 'osInfo') {
            const existingOS = await this.prisma.systemInfo.findFirst({
              where: {
                systemId: searchServers[i].id,
              },
            });

            if (existingOS) {
              const updatedOS = await this.prisma.systemInfo.update({
                where: {
                  id: existingOS.id,
                },
                data: res,
              });

              return { ...updatedOS };
            } else {
              const newOS = await this.prisma.systemInfo.create({
                data: {
                  system: {
                    connect: {
                      id: searchServers[i].id,
                    },
                  },
                  ...res,
                },
              });

              return { ...newOS };
            }
          } else if (data === 'NetworkStats') {
            const existingNetwork =
              await this.prisma.networkInterfaceData.findFirst({
                where: {
                  systemId: searchServers[i].id,
                },
              });

            if (existingNetwork) {
              const updatedNetwork =
                await this.prisma.networkInterfaceData.update({
                  where: {
                    id: existingNetwork.id,
                  },
                  data: res,
                });

              return { ...updatedNetwork };
            } else {
              const newNetwork = await this.prisma.networkInterfaceData.create({
                data: {
                  system: {
                    connect: {
                      id: searchServers[i].id,
                    },
                  },
                  ...res,
                },
              });

              return { ...newNetwork };
            }
          }
        });
      });
    }

    return 'Obtendo dados dos sistemas...';
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

  private toObject(valueData: any) {
    return JSON.parse(
      JSON.stringify(valueData, (key: string, value: any) =>
        typeof value === 'bigint' ? value.toString() : value,
      ),
    );
  }
}
