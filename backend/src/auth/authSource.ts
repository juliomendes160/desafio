import { Secret, SignOptions} from "jsonwebtoken";

export const authSource: { secret: Secret, options: SignOptions} = {
	secret: 'chave-secreta',
	options: { 
		// expiresIn: '1d'
	}
}
