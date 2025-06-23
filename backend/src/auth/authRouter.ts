import { Router } from 'express';

import { AuthController } from './authController';
import { AuthService } from './authService';
import { UserService } from '../user/userService';

export class AuthRouter {
	private router: Router;

	constructor(userService: UserService) {
		const authService = new AuthService(userService);
		const authController = new AuthController(authService);

		this.router = Router();

		this.router.post('/', authController.authenticate);
	}

	get routes() {
		return this.router;
	}
}