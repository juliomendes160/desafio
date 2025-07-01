import express from 'express';

import { dataSource } from './data/dataSource';
import { UserRouter } from './user/userRouter';
import { AuthRouter } from './auth/authRouter';
import { AuthMiddleware } from './auth/authMiddleware';
import { OperationRouter } from './operation/operationRouter';

const app = express();
app.use(express.json());

(async () => {

	try {
		await dataSource.initialize();
		console.log("Sucesso ao conectar banco de dados!");
	}
	catch (error) {
		console.error("Erro ao conectar no banco de dados!", error);
		process.exit(1);
	};

	const userRouter = new UserRouter(dataSource);
	const operationRouter = new OperationRouter(dataSource);

	const authRouter = new AuthRouter(userRouter.service);
	const authMiddleware = new AuthMiddleware();

	app.use('/auth', authRouter.routes);

	app.get('/', (req, res) => {
		res.send('<h1>Realeza Serralharia a melhor do momento Vai querer, kkkkkks</h1>!');
	});

	// app.use(authMiddleware.authorize);

	app.use('/user', userRouter.routes);
	app.use('/operation', operationRouter.routes);

	app.listen(3000, '0.0.0.0', () => {
		console.log('Sucesso ao iniciar servidor!');
	})
		.on('error', (error) => {
			console.error('Erro ao iniciar servidor!', error);
			process.exit(1);
		});

})();
