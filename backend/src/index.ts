import express from 'express';

import { dataSource } from './data/dataSource';
import { UserRouter } from './user/userRouter';

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

	app.use("/user", userRouter.routes);

	app.listen(3000, () => {
		console.log('Sucesso ao iniciar servidor!');
	})
	.on('error', (error) => {
		console.error('Erro ao iniciar servidor!', error);
		process.exit(1);
	});

})();
