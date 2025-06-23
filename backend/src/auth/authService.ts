import jwt from 'jsonwebtoken';

import { authSource } from './authSource';
import { User } from '../user/userEntities';
import { UserService } from '../user/userService';

export class AuthService {
	private userService: UserService;

	constructor(userService: UserService) {
		this.userService = userService;
	}

	authenticate = async (user: Partial<User>) => {
		const userResult = await this.userService.findOneBy({ email: user.email });

		if (!userResult) {
			throw new Error("Usuário não encontrado!");
		}

		if (userResult.password != user.password) {
			throw new Error("Senha inválida!");
		}
		
		const payload = {
			id: userResult.id,
			name: userResult.name,
			email: userResult.email,
			timestamp: Date.now()
		};
		const token = jwt.sign(payload, authSource.secret, authSource.options);
		
		return token;
	}
}