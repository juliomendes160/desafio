import { Request, Response } from 'express';
import { Modules, Actions } from './utilEnum';

export class UtilResponse {

	static success = (req: Request, res: Response, module: Modules, action: Actions, result: any, statusCode: number) => {
		return res.status(statusCode).json({
			module: module,
			action: action,
			data: result,
		});
	}

	static error = (req: Request, res: Response, module: Modules, action: Actions, message: any, statusCode: number) => {
		return res.status(statusCode).json({
			module: module,
			action: action,
			error: message,
		});
	}
}