import { Request, Response } from 'express';

import { User } from './userEntities';
import { UserService } from './userService';

export class UserController {
	private userService: UserService;

	constructor(userService: UserService) {
		this.userService = userService;
	}

	save = async (req: Request, res: Response) => {
		try {
			const user: User = req.body;

			const result = await this.userService.save(user);

			res.status(201).json({ message: "Sucesso ao salvar!", result });
		}
		catch (error: any) {
			res.status(500).json({ message: "Erro ao salvar!", error: error.message });
		}
	}

	find = async (req: Request, res: Response) => {
		try {
			const result = await this.userService.find();

			if (!result) {
				res.status(404).json({ message: "Sucesso ao listar!", result: 'Nenhum um registro encontrado!' });
				return;
			}

			res.status(200).json({ message: "Sucesso ao listar", result });
		}
		catch (error: any) {
			res.status(500).json({ message: "Erro ao listar!", error: error.message });
		}
	}

	findOneBy = async (req: Request, res: Response) => {
		try {
			const user: Partial<User> = { id: Number(req.params.id) };

			const result = await this.userService.findOneBy(user);

			if (!result) {
				res.status(404).json({ message: "Sucesso ao consultar!", result: 'Nenhum um registro encontrado!' });
				return;
			}

			res.status(200).json({ message: "Sucesso ao consultar!", result });
		}
		catch (error: any) {
			res.status(500).json({ message: "Erro ao consultar!", error: error.message });
		}
	}

	update = async (req: Request, res: Response) => {
		try {
			const user: User = { id: Number(req.params.id), ...req.body };

			const result = await this.userService.update(user);

			res.status(200).json({ message: "Sucesso ao atualizar!", result });
		}
		catch (error: any) {
			res.status(500).json({ message: "Erro ao atualizar!", error: error.message });
		}
	}

	delete = async (req: Request, res: Response) => {
		try {
			const id = Number(req.params.id);

			const result = await this.userService.delete(id);

			res.status(200).json({ message: "Sucesso ao deletar!", result });
		}
		catch (error: any) {
			res.status(500).json({ message: "Erro ao deletar!", error: error.message });
		}
	}

}
