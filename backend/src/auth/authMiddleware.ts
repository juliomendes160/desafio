import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

import { authSource } from './authSource';

export class AuthMiddleware {

	authorize = async (req: Request, res: Response, next: NextFunction) => {
		try {
			const token = req.headers.authorization?.split(' ')[1];

			if (!token) {
				throw new Error('Token obrigatório!');
			}

			const payload = jwt.verify(token, authSource.secret);
			next();
		} catch (error: any) {
			res.status(500).json({ message: 'Erro ao autorizar!', error: error.message });
		}
	}
}