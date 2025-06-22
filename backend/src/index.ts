import express from 'express';
import { dataServiceTemp } from './data/dataService';
import { dataSourceTemp } from './data/dataSource';

const app = express();

(async () => {

	try {
		await dataSourceTemp.initialize();
		console.log("Sucesso ao conectar banco de dados!");
	}
	catch (error) {
		console.error("Erro ao conectar no banco de dados!", error);
	}

	try {
		const result = await dataServiceTemp.createDataBase();
		if (result.warningStatus === 0) {
			console.log('Sucesso ao criar banco de dados!');
		}
		else {
			console.log('Sucesso ao acessar banco de dados!');
		}
	} catch (error) {
		console.error("Erro ao criar banco de dados!", error);
	}

	app.listen(3000, () => {
		console.log('Sucesso ao conectar servidor!');
	})
	.on('error', (error) => {
		console.error('Erro ao conectar servidor!', error);
	});
})();
