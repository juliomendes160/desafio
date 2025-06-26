import { Request, Response } from 'express';

import { User } from './userEntities';
import { UserService } from './userService';
import { Modules, Actions } from '../util/utilEnum';
import { UtilResponse } from '../util/utilResponse';


export class UserController {

	private userService: UserService;

	constructor(userService: UserService) {
		this.userService = userService;
	}

	save = async (req: Request, res: Response) => {
		try {
			const user: User = req.body;

			const result = await this.userService.save(user);

			UtilResponse.success(req, res, Modules.USER, Actions.SAVE, result, 201);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.SAVE, error, 500);
		}
	}

	find = async (req: Request, res: Response) => {

		try {
			const result = await this.userService.find();

			if (!result) {
				UtilResponse.success(req, res, Modules.USER, Actions.FIND, result, 404);
				return;
			}

			UtilResponse.success(req, res, Modules.USER, Actions.FIND, result, 200);

		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.FIND, error, 500);
		}
	}

	findOneBy = async (req: Request, res: Response) => {

		try {
			const user: Partial<User> = { id: Number(req.params.id) };

			const result = await this.userService.findOneBy(user);

			if (!result) {
				UtilResponse.success(req, res, Modules.USER, Actions.FIND_ONE_BY, result, 404);
				return;
			}

			UtilResponse.success(req, res, Modules.USER, Actions.FIND_ONE_BY, result, 200);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.FIND_ONE_BY, error, 500);
		}
	}

	update = async (req: Request, res: Response) => {

		try {
			const user: User = { id: Number(req.params.id), ...req.body };

			const result = await this.userService.update(user);

			UtilResponse.success(req, res, Modules.USER, Actions.UPDATE, result, 200);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.UPDATE, error, 500);
		}
	}

	delete = async (req: Request, res: Response) => {

		try {
			const id = Number(req.params.id);

			const result = await this.userService.delete(id);

			UtilResponse.error(req, res, Modules.USER, Actions.DELETE, result, 200);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.DELETE, error, 500);
		}
	}
}
