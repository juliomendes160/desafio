```TypeScript index.ts Async/Await
import express from 'express';
import { dataService } from './data/dataService';
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
		const result = await dataService.createDataBase();
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
```

```TypeScript index.ts Promise chaining e async/await.
dataSourceTemp.initialize()
	.then(async () => {
		console.log("Sucesso ao conectar banco de dados!");

		try {
			const result = await dataService.createDataBase();
			if (result.warningStatus===0){
				console.log('Sucesso ao criar banco de dados!');
			}
			else{
				console.log('Sucesso ao acessar banco de dados!');
			}
		}
		catch (error) {
			console.error("Error ao acessar banco de dados!", error);
			throw error;
		} 
	}) 
	.then(() => {
		app
			.listen(3000, () => {
				console.log('Sucesso ao conectar servidor!');
			})
			.on('error', (error) => {
				console.error('Erro ao conectar servidor!', error);
			});
	})
	.catch((error) => {
		console.error("Erro ao conectar banco de dados!", error);
	});
```

```TypeScript index.ts Promise chaining
dataSourceTemp.initialize()
	.then(() => {
		console.log("Sucesso ao conectar banco de dados!");

		return dataService.createDataBase()
			.then(() => {
				console.log('Sucesso ao acessar banco de dados!');
			})
			.catch((error) => {
				console.error("Error ao acessar banco de dados!", error);
				throw error;
			});
	})
	.then(() => {
		app
			.listen(3000, () => {
				console.log('Sucesso ao conectar servidor!');
			})
			.on('error', (error) => {
				console.error('Erro ao conectar servidor!', error);
			});
	})
	.catch((error) => {
		console.error("Erro ao conectar banco de dados!", error);
	});
```

```TypeScript
```