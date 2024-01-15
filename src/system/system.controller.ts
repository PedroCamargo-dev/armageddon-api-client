import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { SystemService } from './system.service';
import { CreateSystemDto } from './dto/create-system.dto';

@Controller('system')
export class SystemController {
  constructor(private readonly systemService: SystemService) {}

  @Post()
  create(@Body() createSystemDto: CreateSystemDto) {
    return this.systemService.create(createSystemDto);
  }

  @Get('metrics')
  async findAllSystemInfo() {
    return await this.systemService.findAllSystemInfo();
  }

  @Get(':id')
  async startAPIPC(@Param('id') id: string) {
    return this.systemService.startAPI(+id);
  }

  @Post('metrics')
  metricsSystems(@Body() server) {
    return this.systemService.metricsSystems(server);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.systemService.remove(+id);
  }
}
