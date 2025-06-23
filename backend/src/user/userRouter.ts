import { Router } from 'express';
import { UserController } from './userController';
import { UserRepository } from './userRepository';
import { UserService } from './userService';
import { DataSource } from 'typeorm';

export class UserRouter {
	private userRepository: UserRepository;
	private userService: UserService;
	private userController: UserController;
	private router: Router;
	
	constructor(dataSource: DataSource) {
		this.userRepository = new UserRepository(dataSource);
		this.userService = new UserService(this.userRepository);
		this.userController = new UserController(this.userService);

		this.router = Router();

		this.router.post('/', this.userController.save);
		this.router.get('/', this.userController.find);
		this.router.get('/:id', this.userController.findOneBy);
		this.router.put('/:id', this.userController.update);
		this.router.delete('/:id', this.userController.delete);
	}

	get routes() {
		return this.router;
	}

	get service (){
		return this.userService;
	}
}
