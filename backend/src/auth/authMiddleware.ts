import { Request, Response, NextFunction } from 'express';
import jwt, { VerifyOptions } from 'jsonwebtoken';

import { authSource } from './authSource';

export const authMiddleware = {

	autenticar(req: Request, res: Response, next: NextFunction) {
		const authHeader = req.headers.authorization;

		if (!authHeader) {
			res.status(401).json({ mensagem: 'Erro token obrigatório!' });
			return;
		}

		const [, encoded] = authHeader.split(' ');

		if (!encoded) {
			res.status(401).json({ mensagem: 'Erro token mal formatado!' });
			return;
		}

		try {
			const decoded = jwt.verify(encoded, authSource.secretOrPrivateKey, authSource.options as VerifyOptions);
			next();
		} catch (error) {
			res.status(401).json({ mensagem: 'Erro token inválido!' });
		}
	}
}
