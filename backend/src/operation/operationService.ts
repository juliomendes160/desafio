import { StatusCode } from '../util/utilEnum';
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
			throw new UtilError(StatusCode.BadRequest);
		}

		if (!Object.values(Type).some(type => type.toUpperCase() === operation.type.toUpperCase())){
			throw new UtilError(StatusCode.BadRequest);
		}

		if (!Object.values(Product).some(product => product.toUpperCase() === operation.product.toUpperCase())){
			throw new UtilError(StatusCode.BadRequest);
		}

		if (isNaN(operation.quantity)){
			throw new UtilError(StatusCode.BadRequest);
		}

		return await this.operationRepository.save(operation);
	}

	find = async () => {
		return await this.operationRepository.find();
	}

	findOneBy = async (operation: Partial<Operation>) => {
		if (!operation.id && !operation.type && !operation.product && !operation.quantity) {
			throw new UtilError(StatusCode.BadRequest);
		}

		const result = await this.operationRepository.findOneBy(operation);

		if(!result){
			throw new UtilError(StatusCode.NotFound);
		}

		return result;

	}

	update = async (operation: Operation) => {
		if (!operation.id || !operation.type || !operation.product || !operation.quantity) {
			throw new UtilError(StatusCode.BadRequest);
		}

		return await this.operationRepository.update(operation);
	}

	async delete(id: number) {
		if (isNaN(id)) {
			throw new UtilError(StatusCode.BadRequest);
		}

		return await this.operationRepository.delete(id);
	}
}
