import { UtilError } from '../util/utilError';
import { Operation, Product, Type } from './operationEntities';
import { OperationRepository } from './operationRepository';

export class OperationService {
	private operationRepository: OperationRepository;

	constructor(operationRepository: OperationRepository) {
		this.operationRepository = operationRepository;
	}

	save = async (operation: Operation) => {
		if (!operation.type || !operation.product || !operation.quantity) {
			throw new Error('Obrigatório: type, product, quantity');
		}

		if (!Object.values(Type).some(type => type.toUpperCase() === operation.type.toUpperCase())){
			throw new Error('Inválido(a): type!');
		}

		if (!Object.values(Product).some(product => product.toUpperCase() === operation.product.toUpperCase())){
			throw new Error('Inválido(a): type!');
		}

		if (isNaN(operation.quantity)){
			throw new Error('Inválido(a): quantity!');
		}

		return await this.operationRepository.save(operation);
	}

	find = async () => {
		return await this.operationRepository.find();
	}

	findOneBy = async (operation: Partial<Operation>) => {
		if (!operation.id && !operation.type && !operation.product && !operation.quantity) {
			throw new Error("Campos vazios!");
		}

		const result = await this.operationRepository.findOneBy(operation);

		if(!result){
			throw new UtilError(404);
		}

		return result;

	}

	update = async (operation: Operation) => {
		if (!operation.id || !operation.type || !operation.product || !operation.quantity) {
			throw new Error("Campos obrigatórios!");
		}

		// const result = await this.findOneBy({ email: operation.email });

		// if (result && result.id != operation.id) {
		// 	throw new Error("E-mail já cadastrado!");
		// }

		return await this.operationRepository.update(operation);
	}

	async delete(id: number) {
		if (isNaN(id)) {
			throw new Error("Campo inválido!");
		}

		// const result = await this.findOneBy({ id });

		return await this.operationRepository.delete(id);
	}
}
