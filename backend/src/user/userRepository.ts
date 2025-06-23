import { DataSource, Repository } from 'typeorm';

import { User } from './userEntities';

export class UserRepository {
	private repository: Repository<User>;

	constructor(dataSource: DataSource) {
		this.repository = dataSource.getRepository(User);
	}

	save = async (user: User) => {
		return await this.repository.save(user);
	}

	find = async () => {
		return await this.repository.find();
	}

	findOneBy = async (user: Partial<User>) => {
		return await this.repository.findOneBy(user);
	}

	update = async (user: User) => {
		return await this.repository.save(user);
	}

	delete = async (id: number) => {
		return this.repository.delete(id);
	}
}
