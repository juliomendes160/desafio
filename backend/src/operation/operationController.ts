import { Request, Response } from 'express';

import { Operation } from './operationEntities';
import { OperationService } from './operationService';
import { Modules, Actions } from '../util/utilEnum';
import { UtilResponse } from '../util/utilResponse';

export class OperationController {
	private operationService: OperationService;

	constructor(operationService: OperationService) {
		this.operationService = operationService;
	}

	save = async (req: Request, res: Response) => {
		try {
			const operation: Operation = req.body;

			const result = await this.operationService.save(operation);
			
			UtilResponse.success(req, res, Modules.OPERATION, Actions.SAVE, result, 201);
		}
		catch ({ message, statusCode }: any) {
			UtilResponse.error(req, res, Modules.OPERATION, Actions.SAVE, message, statusCode);
		}
	}

	find = async (req: Request, res: Response) => {
		try {
			const result = await this.operationService.find();

			if (!result) {
				UtilResponse.success(req, res, Modules.OPERATION, Actions.FIND, result, 404);
				return;
			}

			UtilResponse.success(req, res, Modules.OPERATION, Actions.FIND, result, 200);
		}
		catch ({ message, statusCode }: any) {
			UtilResponse.error(req, res, Modules.OPERATION, Actions.FIND, message, statusCode);
		}
	}

	findOneBy = async (req: Request, res: Response) => {
		try {
			const operation: Partial<Operation> = { id: Number(req.params.id) };

			const result = await this.operationService.findOneBy(operation);

			UtilResponse.success(req, res, Modules.OPERATION, Actions.FIND_ONE_BY, result, 200);
		}
		catch ({ message, statusCode }: any) {
			UtilResponse.error(req, res, Modules.OPERATION, Actions.FIND_ONE_BY, message, statusCode);
		}
	}

	update = async (req: Request, res: Response) => {
		try {
			const operation: Operation = { id: Number(req.params.id), ...req.body };

			const result = await this.operationService.update(operation);

			UtilResponse.success(req, res, Modules.OPERATION, Actions.UPDATE, result, 200);
		}
		catch ({ message, statusCode }: any) {
			UtilResponse.error(req, res, Modules.OPERATION, Actions.UPDATE, message, statusCode);
		}
	}

	delete = async (req: Request, res: Response) => {
		try {
			const id = Number(req.params.id);

			const result = await this.operationService.delete(id);

			UtilResponse.success(req, res, Modules.OPERATION, Actions.DELETE, result, 200);
		}
		catch ({ message, statusCode }: any) {
			UtilResponse.error(req, res, Modules.OPERATION, Actions.DELETE, message, statusCode);
		}
	}

}

