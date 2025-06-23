import { Request, Response } from 'express';

import { AuthService } from './authService';
import { User } from '../user/userEntities';
export class AuthController {
	private authService: AuthService;

	constructor(authService: AuthService) {
		this.authService = authService;
	}

	authenticate = async (req: Request, res: Response) => {
		try {
			const user: Partial<User> = req.body;

			const token = await this.authService.authenticate(user);

			res.status(200).json({ message: "Sucesso ao autenticar!", token });
		} 
		catch (error: any) {
			res.status(500).json({ message: "Erro ao autenticar!", error: error.message });
		}
	}
}