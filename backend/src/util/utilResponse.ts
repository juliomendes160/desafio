import { Request, Response } from 'express';
import { Modules, Actions } from './utilEnum';

export class UtilResponse {

	static success = (req: Request, res: Response, module: Modules, action: Actions, result: any) => {
		return res.status(200).json({
			module: module,
			action: action,
			data: result,
		});
	}

	static error = (req: Request, res: Response, module: Modules, action: Actions, error: any) => {
		return res.status(error.statusCode || 500).json({
			module: module,
			action: action,
			error: error.message,
		});
	}
}