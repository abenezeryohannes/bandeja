import { NestFactory } from '@nestjs/core';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { AppModule } from './app.module';
import { ValidateInputPipe } from './core/pipes/validate.pipe';
import { contentParser } from 'fastify-multer';
import 'reflect-metadata';

process.env.TZ = '+0:00';

const CORS_OPTIONS = {
  origin: ['http://127.0.0.1:5173'], // or '*' or whatever is required
  allowedHeaders: [
    'Access-Control-Allow-Origin',
    'Origin',
    'X-Requested-With',
    'Accept',
    'Content-Type',
    'Authorization',
  ],
  exposedHeaders: 'Authorization',
  credentials: true,
  methods: ['GET', 'PUT', 'OPTIONS', 'POST', 'DELETE'],
};

// Date.prototype.toJSON = function () {
//   return subtractHours(this, 3).toLocaleString();
// };

// function subtractHours(date, hours) {
//   date.setHours(date.getHours() - hours);
//   return date;
// }

async function bootstrap() {
  const adapter = new FastifyAdapter();
  adapter.enableCors(CORS_OPTIONS);
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    adapter,
  );
  app.register(contentParser);
  app.setGlobalPrefix('api/v1');
  app.useGlobalPipes(new ValidateInputPipe());
  await app.listen(process.env.PORT || 5000, '0.0.0.0');
}
bootstrap();
