import 'reflect-metadata';
import { DataSource, DataSourceOptions } from 'typeorm';

export const dataSource = new DataSource({
	type: 'mysql',
	host: 'localhost',
	port: 3306,
	username: 'root',
	password: 'mysql',
	database: 'cloudged',
	synchronize: true,
	entities: [],
});

export const dataSourceTemp = new DataSource((({database, synchronize, entities, ...dataSourceOptions}) => dataSourceOptions as DataSourceOptions)(dataSource.options));
