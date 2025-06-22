import 'reflect-metadata';
import { DataSource } from 'typeorm';

export const dataSource = new DataSource({
	type: 'mysql',
	host: 'localhost',
	port: 3306,
	username: 'root',
	password: 'mysql',
	database: 'cloudged',
	synchronize: true,
	entities: ['src/*/*Entities.ts'],
});
