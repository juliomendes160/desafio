import { Request, Response } from 'express';

import { authService } from './authService';

export const authController = {
	async logar(req: Request, res: Response) {
		try {
			const encoded = authService.logar();
			res.status(200).json({ message: 'Sucesso ao autenticar!', encoded});
		} catch (error: any) {
			res.status(500).json({ message: 'Erro ao autenticar!', erro: error.message });
		}
	}
}
