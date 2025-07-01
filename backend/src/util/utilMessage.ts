import { StatusCode } from "./utilEnum";

export class UtilMessage {
	static messages: Record<StatusCode, string>  = {
		[StatusCode.BadRequest]: 'Requisição Inválida!',
		[StatusCode.Unauthorized]: 'Sem Autenticação!',
		[StatusCode.Forbidden]: 'Sem Autorização!',
		[StatusCode.NotFound]: 'Não Encontrado!',
		[StatusCode.InternalServerError]: 'Erro no Servidor!',
	};
}
