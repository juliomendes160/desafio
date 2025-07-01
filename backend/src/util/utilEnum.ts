export enum Actions {
	DELETE = 'Deletar',
	FIND = 'Listar',
	FIND_ONE_BY = 'Consultar',
	SAVE = 'Salvar',
	UPDATE = 'Atualizar',
}

export enum Modules {
	USER = 'User',
	OPERATION = 'Operation',
}

export enum StatusCode {
	BadRequest = 400,
	Unauthorized = 401,
	Forbidden = 403,
	NotFound = 404,
	InternalServerError = 500,
}