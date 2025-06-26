import { Router } from 'express';
import { OperationController } from './operationController';
import { OperationRepository } from './operationRepository';
import { OperationService } from './operationService';
import { DataSource } from 'typeorm';

export class OperationRouter {
	private operationRepository: OperationRepository;
	private operationService: OperationService;
	private operationController: OperationController;
	private router: Router;

	constructor(dataSource: DataSource) {
		this.operationRepository = new OperationRepository(dataSource);
		this.operationService = new OperationService(this.operationRepository);
		this.operationController = new OperationController(this.operationService);

		this.router = Router();

		this.router.post('/', this.operationController.save);
		this.router.get('/', this.operationController.find);
		this.router.get('/:id', this.operationController.findOneBy);
		this.router.put('/:id', this.operationController.update);
		this.router.delete('/:id', this.operationController.delete);
	}

	get routes() {
		return this.router;
	}

	get service() {
		return this.operationService;
	}
}
