import { Secret, SignOptions, VerifyOptions } from "jsonwebtoken";

export const authSource: { payload:  string | Buffer | object , secretOrPrivateKey: Secret, options: SignOptions | VerifyOptions} = {
	payload: {timestamp: Date.now()},
	secretOrPrivateKey: 'chave-secreta',
	options: { expiresIn: '1d' }
}
