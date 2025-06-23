import { User } from './userEntities';
import { UserRepository } from './userRepository';

export class UserService {
	private userRepository: UserRepository;

	constructor(userRepository: UserRepository) {
		this.userRepository = userRepository;
	}

	save = async (user: User) => {
		if (!user.name || !user.email || !user.password) {
			throw new Error("Campos obrigatórios!");
		}

		const result = await this.findOneBy({ email: user.email });

		if (result) {
			throw new Error("E-mail já cadastrado!");
		}

		return await this.userRepository.save(user);
	}

	find = async () => {
		return await this.userRepository.find();
	}

	findOneBy = async (user: Partial<User>) => {
		if (!user.id && !user.name && !user.email && !user.password) {
			throw new Error("Campos vazios!");
		}

		return await this.userRepository.findOneBy(user);
	}

	update = async (user: User) => {
		if (!user.id || !user.name || !user.email || !user.password) {
			throw new Error("Campos obrigatórios!");
		}

		const result = await this.findOneBy({ email: user.email });

		if (result && result.id != user.id) {
			throw new Error("E-mail já cadastrado!");
		}

		return await this.userRepository.update(user);
	}

	async delete(id: number) {
		if (isNaN(id)) {
			throw new Error("Campo inválido!");
		}

		const result = await this.findOneBy({id});

		return await this.userRepository.delete(id);
	}
}