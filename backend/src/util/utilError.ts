import { StatusCode } from './utilEnum';
import { UtilMessage } from './utilMessage';

export class UtilError extends Error {
	public statusCode: StatusCode;

	constructor(statusCode: StatusCode) {
		super(UtilMessage.messages[statusCode]);
		this.statusCode = statusCode;
		Object.setPrototypeOf(this, UtilError.prototype);
	}
}
