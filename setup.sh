# chore: initial commit

	# MySQL Installer
	https://www.mysql.com/
	https://cdn.mysql.com//Downloads/MySQLInstaller/mysql-installer-web-community-8.0.42.0.msi

	# MySQL Server
	https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.42-winx64.zip

	# MySQL Workbench
	https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-8.0.42-winx64.msi

	# Node.js
	https://nodejs.org/pt
	https://nodejs.org/dist/v16.16.0/node-v16.16.0-x64.msi

# chore: setup environment

	mkdir backend
	cd backend

	npx gitignore node

	npm init -y

	npm install express

	npm install typescript --save-dev
	npm install ts-node-dev --save-dev
	npm install @types/node --save-dev
	npm install @types/express --save-dev

	npx tsc --init

# chore: setup server

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
		import express from 'express';

		const app = express();

		app.listen(3000, () => {
			console.log('Sucesso ao conectar servidor!');
		}); 
	EOF

	npx ts-node-dev src/index.ts

# chore: setup database
	
	npm install reflect-metadata
	npm install typeorm
	npm install mysql2

	mkdir src/data -p
	touch src/data/dataSource.ts
	code src/data/dataSource.ts
	cat <<- EOF > src/data/dataSource.ts
		import 'reflect-metadata';
		import { DataSource, DataSourceOptions } from 'typeorm';

		export const dataSource = new DataSource({
			type: 'mysql',
			host: 'localhost',
			port: 3306,
			username: 'root',
			password: 'mysql',
			database: 'cloudged',
			synchronize: true,
			entities: [],
		});

		export const dataSourceTemp = new DataSource((({database, synchronize, entities, ...dataSourceOptions}) => dataSourceOptions as DataSourceOptions)(dataSource.options));
	EOF

	mkdir src/data -p
	touch src/data/dataService.ts
	code src/data/dataService.ts
	cat <<- EOF > src/data/dataService.ts
		import { dataSource, dataSourceTemp } from "./dataSource";

		export const dataServiceTemp = {

			async createDataBase() {
				const database = dataSource.options.database;
				const queryRunner = dataSourceTemp.createQueryRunner();
				try {
					await queryRunner.connect();
					return await queryRunner.query(`CREATE DATABASE IF NOT EXISTS ${database}`);
				} finally {
					await queryRunner.release();
				}
			}
		}
	EOF

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
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
	EOF

# feat: autenticação
	npm install jsonwebtoken
	npm install @types/jsonwebtoken --save-dev

	mkdir src/auth -p
	touch src/auth/authSource.ts
	code src/auth/authSource.ts
	cat <<- EOF > src/auth/authSource.ts
		import { Secret, SignOptions, VerifyOptions } from "jsonwebtoken";

		export const authSource: { payload:  string | Buffer | object , secretOrPrivateKey: Secret, options: SignOptions | VerifyOptions} = {
			payload: {timestamp: Date.now()},
			secretOrPrivateKey: 'chave-secreta',
			options: { expiresIn: '1d' }
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authService.ts
	code src/auth/authService.ts
	cat <<- EOF > src/auth/authService.ts
		import jwt, { SignOptions } from 'jsonwebtoken';

		import { authSource } from './authSource';

		export const authService = {
			logar() {
				return jwt.sign(authSource.payload, authSource.secretOrPrivateKey, authSource.options as SignOptions);
			}
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authController.ts
	code src/auth/authController.ts
	cat <<- EOF > src/auth/authController.ts
		import { Request, Response } from 'express';

		import { authService } from './authService';

		export const authController = {
			async logar(req: Request, res: Response) {
				try {
					const encoded = authService.logar();
					res.status(200).json({ message: 'Sucesso ao autenticar!', encoded});
				} catch (error: any) {
					res.status(500).json({ message: 'Erro ao autenticar!', erro: error.message });
				}
			}
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authMiddleware.ts
	code src/auth/authMiddleware.ts
	cat <<- EOF > src/auth/authMiddleware.ts
		import { Request, Response, NextFunction } from 'express';
		import jwt, { VerifyOptions } from 'jsonwebtoken';

		import { authSource } from './authSource';

		export const authMiddleware = {

			autenticar(req: Request, res: Response, next: NextFunction) {
				const authHeader = req.headers.authorization;

				if (!authHeader) {
					res.status(401).json({ mensagem: 'Erro token obrigatório!' });
					return;
				}

				const [, encoded] = authHeader.split(' ');

				if (!encoded) {
					res.status(401).json({ mensagem: 'Erro token mal formatado!' });
					return;
				}

				try {
					const decoded = jwt.verify(encoded, authSource.secretOrPrivateKey, authSource.options as VerifyOptions);
					next();
				} catch (error) {
					res.status(401).json({ mensagem: 'Erro token inválido!' });
				}
			}
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authRouter.ts
	code src/auth/authRouter.ts
	cat <<- EOF > src/auth/authRouter.ts
		import { Router } from 'express';

		import { authController } from './authController';
		import { authMiddleware } from './authMiddleware';

		export const authRouter = Router();
		authRouter.use(authMiddleware.autenticar);
		authRouter.post("/", authController.logar);
	EOF

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
		import express from 'express';

		import { authRouter } from './auth/authRouter';
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

			app.use("/auth", authRouter);

			app.listen(3000, () => {
				console.log('Sucesso ao conectar servidor!');
			})
				.on('error', (error) => {
					console.error('Erro ao conectar servidor!', error);
				});
		})();
	EOF
