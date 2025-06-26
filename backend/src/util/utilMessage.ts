export class UtilMessage {
	static messages: { [key: number]: string } = {
		400: 'Requisição Inválida',
		401: 'Sem Autenticação',
		403: 'Sem Autorização',
		404: 'Não Encontrado',
		500: 'Erro no Servidor',
	};
}
