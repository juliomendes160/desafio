import { dataSource, dataSourceTemp } from "./dataSource";

export const dataServiceTemp = {

	async createDataBase() {
		const database = dataSource.options.database;
		const queryRunner = dataSourceTemp.createQueryRunner();
		try {
			await queryRunner.connect();
			return await queryRunner.query(`CREATE DATABASE IF NOT EXISTS ${database}`);
		} finally {
			await queryRunner.release();
		}
	}
}
