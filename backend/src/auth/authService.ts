import jwt, { SignOptions } from 'jsonwebtoken';

import { authSource } from './authSource';

export const authService = {
	logar() {
		return jwt.sign(authSource.payload, authSource.secretOrPrivateKey, authSource.options as SignOptions);
	}
}
