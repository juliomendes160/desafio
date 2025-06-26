import { DataSource, Repository } from 'typeorm';

import { Operation } from './operationEntities';

export class OperationRepository {
	private repository: Repository<Operation>;

	constructor(dataSource: DataSource) {
		this.repository = dataSource.getRepository(Operation);
	}

	save = async (operation: Operation) => {
		return await this.repository.save(operation);
	}

	find = async () => {
		return await this.repository.find();
	}

	findOneBy = async (operation: Partial<Operation>) => {
		return await this.repository.findOneBy(operation);
	}

	update = async (operation: Operation) => {
		return await this.repository.save(operation);
	}

	delete = async (id: number) => {
		return this.repository.delete(id);
	}
}
