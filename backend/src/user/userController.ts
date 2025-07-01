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

			UtilResponse.success(req, res, Modules.USER, Actions.SAVE, result);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.SAVE, error);
		}
	}

	find = async (req: Request, res: Response) => {

		try {
			const result = await this.userService.find();

			UtilResponse.success(req, res, Modules.USER, Actions.FIND, result);

		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.FIND, error);
		}
	}

	findOneBy = async (req: Request, res: Response) => {

		try {
			const user: Partial<User> = { id: Number(req.params.id) };

			const result = await this.userService.findOneBy(user);

			UtilResponse.success(req, res, Modules.USER, Actions.FIND_ONE_BY, result);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.FIND_ONE_BY, error);
		}
	}

	update = async (req: Request, res: Response) => {

		try {
			const user: User = { id: Number(req.params.id), ...req.body };

			const result = await this.userService.update(user);

			UtilResponse.success(req, res, Modules.USER, Actions.UPDATE, result);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.UPDATE, error);
		}
	}

	delete = async (req: Request, res: Response) => {

		try {
			const id = Number(req.params.id);

			const result = await this.userService.delete(id);

			UtilResponse.error(req, res, Modules.USER, Actions.DELETE, result);
		}
		catch (error: any) {
			UtilResponse.error(req, res, Modules.USER, Actions.DELETE, error);
		}
	}
}
