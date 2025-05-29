// src/prisma/prisma.service.ts
import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService 
  extends PrismaClient 
  implements OnModuleInit, OnModuleDestroy {
  
  constructor() {
    super({
      log: ['query', 'info', 'warn', 'error'],
    });
  }

  async onModuleInit() {
    try {
      await this.$connect();
      console.log('Prisma connected successfully');
    } catch (error) {
      console.error('Prisma connection error', error);
      process.exit(1); // Encerra o app se não conectar
    }
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}