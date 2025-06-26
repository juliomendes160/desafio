# chore: initial commit

	# MySQL Installer
	https://www.mysql.com/
	https://cdn.mysql.com//Downloads/MySQLInstaller/mysql-installer-web-community-8.0.42.0.msi

	# MySQL Server
	https://www.mysql.com/
	https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.42-winx64.zip

	# MySQL Workbench
	https://www.mysql.com/
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

	mysql -u root -pmysql -e "DROP DATABASE IF EXISTS cloudged; CREATE DATABASE IF NOT EXISTS cloudged;"

	npm install reflect-metadata
	npm install typeorm
	npm install mysql2
	npm install bcryptjs

	mkdir src/data -p
	touch src/data/dataSource.ts
	code src/data/dataSource.ts
	cat <<- EOF > src/data/dataSource.ts
		import 'reflect-metadata';
		import { DataSource } from 'typeorm';

		export const dataSource = new DataSource({
			type: 'mysql',
			host: 'localhost',
			port: 3306,
			username: 'root',
			password: 'mysql',
			database: 'cloudged',
			synchronize: true,
			entities: ['src/entities/*.ts'],
		});
	EOF

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
		import express from 'express';

		import { dataSource } from './data/dataSource';

		const app = express();

		(async () => {

			try {
				await dataSource.initialize();
				console.log("Sucesso ao conectar banco de dados!");
			}
			catch (error) {
				console.error("Erro ao conectar no banco de dados!", error);
				process.exit(1);
			};

			app.listen(3000, () => {
				console.log('Sucesso ao iniciar servidor!');
			})
			.on('error', (error) => {
				console.error('Erro ao iniciar servidor!', error);
				process.exit(1);
			});

		})();
	EOF
# feat: user

	code tsconfig.json
	cat <<- EOF > tsconfig.json
		{
			"compilerOptions": {
				/* Visit https://aka.ms/tsconfig to read more about this file */
				/* Projects */
				// "incremental": true,                              /* Save .tsbuildinfo files to allow for incremental compilation of projects. */
				// "composite": true,                                /* Enable constraints that allow a TypeScript project to be used with project references. */
				// "tsBuildInfoFile": "./.tsbuildinfo",              /* Specify the path to .tsbuildinfo incremental compilation file. */
				// "disableSourceOfProjectReferenceRedirect": true,  /* Disable preferring source files instead of declaration files when referencing composite projects. */
				// "disableSolutionSearching": true,                 /* Opt a project out of multi-project reference checking when editing. */
				// "disableReferencedProjectLoad": true,             /* Reduce the number of projects loaded automatically by TypeScript. */
				/* Language and Environment */
				"target": "es2016", /* Set the JavaScript language version for emitted JavaScript and include compatible library declarations. */
				// "lib": [],                                        /* Specify a set of bundled library declaration files that describe the target runtime environment. */
				// "jsx": "preserve",                                /* Specify what JSX code is generated. */
				// "libReplacement": true,                           /* Enable lib replacement. */
				"experimentalDecorators": true, /* Enable experimental support for legacy experimental decorators. */
				"emitDecoratorMetadata": true, /* Emit design-type metadata for decorated declarations in source files. */
				// "jsxFactory": "",                                 /* Specify the JSX factory function used when targeting React JSX emit, e.g. 'React.createElement' or 'h'. */
				// "jsxFragmentFactory": "",                         /* Specify the JSX Fragment reference used for fragments when targeting React JSX emit e.g. 'React.Fragment' or 'Fragment'. */
				// "jsxImportSource": "",                            /* Specify module specifier used to import the JSX factory functions when using 'jsx: react-jsx*'. */
				// "reactNamespace": "",                             /* Specify the object invoked for 'createElement'. This only applies when targeting 'react' JSX emit. */
				// "noLib": true,                                    /* Disable including any library files, including the default lib.d.ts. */
				// "useDefineForClassFields": true,                  /* Emit ECMAScript-standard-compliant class fields. */
				// "moduleDetection": "auto",                        /* Control what method is used to detect module-format JS files. */
				/* Modules */
				"module": "commonjs", /* Specify what module code is generated. */
				// "rootDir": "./",                                  /* Specify the root folder within your source files. */
				// "moduleResolution": "node10",                     /* Specify how TypeScript looks up a file from a given module specifier. */
				// "baseUrl": "./",                                  /* Specify the base directory to resolve non-relative module names. */
				// "paths": {},                                      /* Specify a set of entries that re-map imports to additional lookup locations. */
				// "rootDirs": [],                                   /* Allow multiple folders to be treated as one when resolving modules. */
				// "typeRoots": [],                                  /* Specify multiple folders that act like './node_modules/@types'. */
				// "types": [],                                      /* Specify type package names to be included without being referenced in a source file. */
				// "allowUmdGlobalAccess": true,                     /* Allow accessing UMD globals from modules. */
				// "moduleSuffixes": [],                             /* List of file name suffixes to search when resolving a module. */
				// "allowImportingTsExtensions": true,               /* Allow imports to include TypeScript file extensions. Requires '--moduleResolution bundler' and either '--noEmit' or '--emitDeclarationOnly' to be set. */
				// "rewriteRelativeImportExtensions": true,          /* Rewrite '.ts', '.tsx', '.mts', and '.cts' file extensions in relative import paths to their JavaScript equivalent in output files. */
				// "resolvePackageJsonExports": true,                /* Use the package.json 'exports' field when resolving package imports. */
				// "resolvePackageJsonImports": true,                /* Use the package.json 'imports' field when resolving imports. */
				// "customConditions": [],                           /* Conditions to set in addition to the resolver-specific defaults when resolving imports. */
				// "noUncheckedSideEffectImports": true,             /* Check side effect imports. */
				// "resolveJsonModule": true,                        /* Enable importing .json files. */
				// "allowArbitraryExtensions": true,                 /* Enable importing files with any extension, provided a declaration file is present. */
				// "noResolve": true,                                /* Disallow 'import's, 'require's or '<reference>'s from expanding the number of files TypeScript should add to a project. */
				/* JavaScript Support */
				// "allowJs": true,                                  /* Allow JavaScript files to be a part of your program. Use the 'checkJS' option to get errors from these files. */
				// "checkJs": true,                                  /* Enable error reporting in type-checked JavaScript files. */
				// "maxNodeModuleJsDepth": 1,                        /* Specify the maximum folder depth used for checking JavaScript files from 'node_modules'. Only applicable with 'allowJs'. */
				/* Emit */
				// "declaration": true,                              /* Generate .d.ts files from TypeScript and JavaScript files in your project. */
				// "declarationMap": true,                           /* Create sourcemaps for d.ts files. */
				// "emitDeclarationOnly": true,                      /* Only output d.ts files and not JavaScript files. */
				// "sourceMap": true,                                /* Create source map files for emitted JavaScript files. */
				// "inlineSourceMap": true,                          /* Include sourcemap files inside the emitted JavaScript. */
				// "noEmit": true,                                   /* Disable emitting files from a compilation. */
				// "outFile": "./",                                  /* Specify a file that bundles all outputs into one JavaScript file. If 'declaration' is true, also designates a file that bundles all .d.ts output. */
				// "outDir": "./",                                   /* Specify an output folder for all emitted files. */
				// "removeComments": true,                           /* Disable emitting comments. */
				// "importHelpers": true,                            /* Allow importing helper functions from tslib once per project, instead of including them per-file. */
				// "downlevelIteration": true,                       /* Emit more compliant, but verbose and less performant JavaScript for iteration. */
				// "sourceRoot": "",                                 /* Specify the root path for debuggers to find the reference source code. */
				// "mapRoot": "",                                    /* Specify the location where debugger should locate map files instead of generated locations. */
				// "inlineSources": true,                            /* Include source code in the sourcemaps inside the emitted JavaScript. */
				// "emitBOM": true,                                  /* Emit a UTF-8 Byte Order Mark (BOM) in the beginning of output files. */
				// "newLine": "crlf",                                /* Set the newline character for emitting files. */
				// "stripInternal": true,                            /* Disable emitting declarations that have '@internal' in their JSDoc comments. */
				// "noEmitHelpers": true,                            /* Disable generating custom helper functions like '__extends' in compiled output. */
				// "noEmitOnError": true,                            /* Disable emitting files if any type checking errors are reported. */
				// "preserveConstEnums": true,                       /* Disable erasing 'const enum' declarations in generated code. */
				// "declarationDir": "./",                           /* Specify the output directory for generated declaration files. */
				/* Interop Constraints */
				// "isolatedModules": true,                          /* Ensure that each file can be safely transpiled without relying on other imports. */
				// "verbatimModuleSyntax": true,                     /* Do not transform or elide any imports or exports not marked as type-only, ensuring they are written in the output file's format based on the 'module' setting. */
				// "isolatedDeclarations": true,                     /* Require sufficient annotation on exports so other tools can trivially generate declaration files. */
				// "erasableSyntaxOnly": true,                       /* Do not allow runtime constructs that are not part of ECMAScript. */
				// "allowSyntheticDefaultImports": true,             /* Allow 'import x from y' when a module doesn't have a default export. */
				"esModuleInterop": true, /* Emit additional JavaScript to ease support for importing CommonJS modules. This enables 'allowSyntheticDefaultImports' for type compatibility. */
				// "preserveSymlinks": true,                         /* Disable resolving symlinks to their realpath. This correlates to the same flag in node. */
				"forceConsistentCasingInFileNames": true, /* Ensure that casing is correct in imports. */
				/* Type Checking */
				"strict": true, /* Enable all strict type-checking options. */
				// "noImplicitAny": true,                            /* Enable error reporting for expressions and declarations with an implied 'any' type. */
				// "strictNullChecks": true,                         /* When type checking, take into account 'null' and 'undefined'. */
				// "strictFunctionTypes": true,                      /* When assigning functions, check to ensure parameters and the return values are subtype-compatible. */
				// "strictBindCallApply": true,                      /* Check that the arguments for 'bind', 'call', and 'apply' methods match the original function. */
				// "strictPropertyInitialization": true,             /* Check for class properties that are declared but not set in the constructor. */
				// "strictBuiltinIteratorReturn": true,              /* Built-in iterators are instantiated with a 'TReturn' type of 'undefined' instead of 'any'. */
				// "noImplicitThis": true,                           /* Enable error reporting when 'this' is given the type 'any'. */
				// "useUnknownInCatchVariables": true,               /* Default catch clause variables as 'unknown' instead of 'any'. */
				// "alwaysStrict": true,                             /* Ensure 'use strict' is always emitted. */
				// "noUnusedLocals": true,                           /* Enable error reporting when local variables aren't read. */
				// "noUnusedParameters": true,                       /* Raise an error when a function parameter isn't read. */
				// "exactOptionalPropertyTypes": true,               /* Interpret optional property types as written, rather than adding 'undefined'. */
				// "noImplicitReturns": true,                        /* Enable error reporting for codepaths that do not explicitly return in a function. */
				// "noFallthroughCasesInSwitch": true,               /* Enable error reporting for fallthrough cases in switch statements. */
				// "noUncheckedIndexedAccess": true,                 /* Add 'undefined' to a type when accessed using an index. */
				// "noImplicitOverride": true,                       /* Ensure overriding members in derived classes are marked with an override modifier. */
				// "noPropertyAccessFromIndexSignature": true,       /* Enforces using indexed accessors for keys declared using an indexed type. */
				// "allowUnusedLabels": true,                        /* Disable error reporting for unused labels. */
				// "allowUnreachableCode": true,                     /* Disable error reporting for unreachable code. */
				/* Completeness */
				// "skipDefaultLibCheck": true,                      /* Skip type checking .d.ts files that are included with TypeScript. */
				"skipLibCheck": true /* Skip type checking all .d.ts files. */
			}
		}
	EOF

	mkdir src/user -p
	touch src/user/userEntities.ts
	code src/user/userEntities.ts
	cat <<- EOF > src/user/userEntities.ts
		import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
		import { UserInterface } from './userInterface';

		@Entity()
		export class User {
			@PrimaryGeneratedColumn()
			id!: number;

			@Column()
			name!: string;

			@Column({ unique: true })
			email!: string;

			@Column()
			password!: string;
		}
	EOF

	mkdir src/user -p
	touch src/user/userRepository.ts
	code src/user/userRepository.ts
	cat <<- EOF > src/user/userRepository.ts
		import { DataSource, Repository } from 'typeorm';

		import { User } from './userEntities';

		export class UserRepository {
			private repository: Repository<User>;

			constructor(dataSource: DataSource) {
				this.repository = dataSource.getRepository(User);
			}

			save = async (user: User) => {
				return await this.repository.save(user);
			}

			find = async () => {
				return await this.repository.find();
			}

			findOneBy = async (user: Partial<User>) => {
				return await this.repository.findOneBy(user);
			}

			update = async (user: User) => {
				return await this.repository.save(user);
			}

			delete = async (id: number) => {
				return this.repository.delete(id);
			}
		}
	EOF

	mkdir src/user -p
	touch src/user/userService.ts
	code src/user/userService.ts
	cat <<- EOF > src/user/userService.ts
		import { User } from './userEntities';
		import { UserRepository } from './userRepository';

		export class UserService {
			private userRepository: UserRepository;

			constructor(userRepository: UserRepository) {
				this.userRepository = userRepository;
			}

			save = async (user: User) => {
				if (!user.name || !user.email || !user.password) {
					throw new Error("Campos obrigatórios!");
				}

				const result = await this.findOneBy({ email: user.email });

				if (result) {
					throw new Error("E-mail já cadastrado!");
				}

				return await this.userRepository.save(user);
			}

			find = async () => {
				return await this.userRepository.find();
			}

			findOneBy = async (user: Partial<User>) => {
				if (!user.id && !user.name && !user.email && !user.password) {
					throw new Error("Campos vazios!");
				}

				return await this.userRepository.findOneBy(user);
			}

			update = async (user: User) => {
				if (!user.id || !user.name || !user.email || !user.password) {
					throw new Error("Campos obrigatórios!");
				}

				const result = await this.findOneBy({ email: user.email });

				if (result && result.id != user.id) {
					throw new Error("E-mail já cadastrado!");
				}

				return await this.userRepository.update(user);
			}

			async delete(id: number) {
				if (isNaN(id)) {
					throw new Error("Campo inválido!");
				}

				const result = await this.findOneBy({id});

				return await this.userRepository.delete(id);
			}
		}
	EOF

	mkdir src/user -p
	touch src/user/userController.ts
	code src/user/userController.ts
	cat <<- EOF > src/user/userController.ts
		import { Request, Response } from 'express';

		import { User } from './userEntities';
		import { UserService } from './userService';

		export class UserController {
			private userService: UserService;

			constructor(userService: UserService) {
				this.userService = userService;
			}

			save = async (req: Request, res: Response) => {
				try {
					const user: User = req.body;

					const result = await this.userService.save(user);

					res.status(201).json({ message: "Sucesso ao salvar!", result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao salvar!", error: error.message });
				}
			}

			find = async (req: Request, res: Response) => {
				try {
					const result = await this.userService.find();

					if (!result) {
						res.status(404).json({ message: "Sucesso ao listar!", result: 'Nenhum um registro encontrado!' });
						return;
					}

					res.status(200).json({ message: "Sucesso ao listar", result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao listar!", error: error.message });
				}
			}

			findOneBy = async (req: Request, res: Response) => {
				try {
					const user: Partial<User> = { id: Number(req.params.id) };

					const result = await this.userService.findOneBy(user);

					if (!result) {
						res.status(404).json({ message: "Sucesso ao consultar!", result: 'Nenhum um registro encontrado!' });
						return;
					}

					res.status(200).json({ message: "Sucesso ao consultar!", result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao consultar!", error: error.message });
				}
			}

			update = async (req: Request, res: Response) => {
				try {
					const user: User = { id: Number(req.params.id), ...req.body };

					const result = await this.userService.update(user);

					res.status(200).json({ message: "Sucesso ao atualizar!", result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao atualizar!", error: error.message });
				}
			}

			delete = async (req: Request, res: Response) => {
				try {
					const id = Number(req.params.id);

					const result = await this.userService.delete(id);

					res.status(200).json({ message: "Sucesso ao deletar!", result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao deletar!", error: error.message });
				}
			}

		}
	EOF

	mkdir src/user -p
	touch src/user/userRouter.ts
	code src/user/userRouter.ts
	cat <<- EOF > src/user/userRouter.ts
		import { Router } from 'express';
		import { UserController } from './userController';
		import { UserRepository } from './userRepository';
		import { UserService } from './userService';
		import { DataSource } from 'typeorm';

		export class UserRouter {
			private userRepository: UserRepository;
			private userService: UserService;
			private userController: UserController;
			private router: Router;
			
			constructor(dataSource: DataSource) {
				this.userRepository = new UserRepository(dataSource);
				this.userService = new UserService(this.userRepository);
				this.userController = new UserController(this.userService);

				this.router = Router();

				this.router.post('/', this.userController.save);
				this.router.get('/', this.userController.find);
				this.router.get('/:id', this.userController.findOneBy);
				this.router.put('/:id', this.userController.update);
				this.router.delete('/:id', this.userController.delete);
			}

			get routes() {
				return this.router;
			}

			get service (){
				return this.userService;
			}
		}
	EOF

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
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
	EOF

# feat: auth
	npm install jsonwebtoken
	npm install bcryptjs

	npm install @types/jsonwebtoken --save-dev
	npm install @types/bcryptjs --save-dev

	mkdir src/auth -p
	touch src/auth/authSource.ts
	code src/auth/authSource.ts
	cat <<- EOF > src/auth/authSource.ts
		import { Secret, SignOptions} from "jsonwebtoken";

		export const authSource: { secret: Secret, options: SignOptions} = {
			secret: 'chave-secreta',
			options: { expiresIn: '1d' }
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authService.ts
	code src/auth/authService.ts
	cat <<- EOF > src/auth/authService.ts
		import jwt from 'jsonwebtoken';

		import { authSource } from './authSource';
		import { User } from '../user/userEntities';
		import { UserService } from '../user/userService';

		export class AuthService {
			private userService: UserService;

			constructor(userService: UserService) {
				this.userService = userService;
			}

			authenticate = async (user: Partial<User>) => {
				const userResult = await this.userService.findOneBy({ email: user.email });

				if (!userResult) {
					throw new Error("Usuário não encontrado!");
				}

				if (userResult.password != user.password) {
					throw new Error("Senha inválida!");
				}
				
				const payload = {
					id: userResult.id,
					name: userResult.name,
					email: userResult.email,
					timestamp: Date.now()
				};
				const token = jwt.sign(payload, authSource.secret, authSource.options);
				
				return token;
			}
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authController.ts
	code src/auth/authController.ts
	cat <<- EOF > src/auth/authController.ts
		import { Request, Response } from 'express';

		import { AuthService } from './authService';
		import { User } from '../user/userEntities';


		export class AuthController {
			private authService: AuthService;

			constructor(authService: AuthService) {
				this.authService = authService;
			}

			authenticate = async (req: Request, res: Response) => {
				try {
					const user: Partial<User> = req.body;

					const token = await this.authService.authenticate(user);

					res.status(200).json({ message: "Sucesso ao logar!", token });
				} 
				catch (error: any) {
					res.status(500).json({ message: "Erro ao logar!", error: error.message });
				}
			}
		}
	EOF

	mkdir src/auth -p
	touch src/auth/authRouter.ts
	code src/auth/authRouter.ts
	cat <<- EOF > src/auth/authRouter.ts
		import { Router } from 'express';
		import { AuthController } from './authController';
		import { AuthService } from './authService';
		import { UserService } from '../user/userService';

		export class AuthRouter {
			private router: Router;

			constructor(userService: UserService) {
				const authService = new AuthService(userService);
				const authController = new AuthController(authService);

				this.router = Router();

				this.router.post('/', authController.authenticate);
			}

			get routes() {
				return this.router;
			}
		}
	EOF

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
		import express from 'express';

		import { dataSource } from './data/dataSource';
		import { UserRouter } from './user/userRouter';
		import { AuthRouter } from './auth/authRouter';
		import { AuthMiddleware } from './auth/authMiddleware';

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
			const authRouter = new AuthRouter(userRouter.service);
			const authMiddleware = new AuthMiddleware();

			app.use('/auth', authRouter.routes);

			app.use(authMiddleware.authorize);
			app.use('/user', userRouter.routes);

			app.listen(3000, () => {
				console.log('Sucesso ao iniciar servidor!');
			})
			.on('error', (error) => {
				console.error('Erro ao iniciar servidor!', error);
				process.exit(1);
			});

		})();
	EOF

	mkdir src/auth -p
	touch src/auth/authMiddleware.ts
	code src/auth/authMiddleware.ts
	cat <<- EOF > src/auth/authMiddleware.ts
		import { Request, Response, NextFunction } from 'express';
		import jwt from 'jsonwebtoken';

		import { authSource } from './authSource';

		export class AuthMiddleware {

			authorize = async (req: Request, res: Response, next: NextFunction) => {
				try {
					const token = req.headers.authorization?.split(' ')[1];

					if (!token) {
						throw new Error('Token obrigatório!');
					}

					const payload = jwt.verify(token, authSource.secret);
					next();
				} catch (error: any) {
					res.status(500).json({ message: 'Erro ao autenticar!', error: error.message });
				}
			}
		}
	EOF
# feat: operation

	mkdir src/operation -p
	touch src/operation/operationEntities.ts
	code src/operation/operationEntities.ts
	cat <<- EOF > src/operation/operationEntities.ts
		import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

		@Entity()
		export class Operation {
			@PrimaryGeneratedColumn()
			id!: number;

			@Column()
			type!: 'compra' | 'venda';

			@Column({ unique: true })
			product!: 'gasolina' | 'etanol' | 'diesel';

			@Column()
			quantity!: number;
		}
	EOF

	mkdir src/operation -p
	touch src/operation/operationRepository.ts
	code src/operation/operationRepository.ts
	cat <<- EOF > src/operation/operationRepository.ts
		import { DataSource, Repository } from 'typeorm';

		import { Operation } from './operationEntities';

		export class OperationRepository {
			private repository: Repository<Operation>;

			constructor(dataSource: DataSource) {
				this.repository = dataSource.getRepository(Operation);
			}

			save = async (user: Operation) => {
				return await this.repository.save(user);
			}

			find = async () => {
				return await this.repository.find();
			}

			findOneBy = async (user: Partial<Operation>) => {
				return await this.repository.findOneBy(user);
			}

			update = async (user: Operation) => {
				return await this.repository.save(user);
			}

			delete = async (id: number) => {
				return this.repository.delete(id);
			}
		}
	EOF

	mkdir src/operation -p
	touch src/operation/operationService.ts
	code src/operation/operationService.ts
	cat <<- EOF > src/operation/operationService.ts
		import { Operation } from './operationEntities';
		import { OperationRepository } from './operationRepository';

		export class OperationService {
			private operationRepository: OperationRepository;

			constructor(operationRepository: OperationRepository) {
				this.operationRepository = operationRepository;
			}

			save = async (operation: Operation) => {
				if (!operation.type || !operation.product || !operation.quantity) {
					throw new Error("Campos obrigatórios!");
				}

				// const result = await this.findOneBy({ email: operation.email });

				// if (result) {
				// 	throw new Error("E-mail já cadastrado!");
				// }

				return await this.operationRepository.save(operation);
			}

			find = async () => {
				return await this.operationRepository.find();
			}

			findOneBy = async (operation: Partial<Operation>) => {
				if (!operation.id || !operation.type || !operation.product || !operation.quantity) {
					throw new Error("Campos vazios!");
				}

				return await this.operationRepository.findOneBy(operation);
			}

			update = async (operation: Operation) => {
				if (!operation.id || !operation.type || !operation.product || !operation.quantity) {
					throw new Error("Campos obrigatórios!");
				}

				// const result = await this.findOneBy({ email: operation.email });

				// if (result && result.id != operation.id) {
				// 	throw new Error("E-mail já cadastrado!");
				// }

				return await this.operationRepository.update(operation);
			}

			async delete(id: number) {
				if (isNaN(id)) {
					throw new Error("Campo inválido!");
				}

				const result = await this.findOneBy({ id });

				return await this.operationRepository.delete(id);
			}
		}
	EOF

	mkdir src/operation -p
	touch src/operation/operationController.ts
	code src/operation/operationController.ts
	cat <<- EOF > src/operation/operationController.ts
		import { Request, Response } from 'express';

		import { Operation } from './operationEntities';
		import { OperationService } from './operationService';

		export class OperationController {
			private operationService: OperationService;

			constructor(operationService: OperationService) {
				this.operationService = operationService;
			}

			save = async (req: Request, res: Response) => {
				try {
					const operation: Operation = req.body;

					const result = await this.operationService.save(operation);

					res.status(201).json({ message: "Sucesso ao salvar!", result: result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao salvar!", error: error.message });
				}
			}

			find = async (req: Request, res: Response) => {
				try {
					const result = await this.operationService.find();

					if (!result) {
						res.status(404).json({ message: "Sucesso ao listar!", result: 'Nenhum um registro encontrado!' });
						return;
					}

					res.status(200).json({ message: "Sucesso ao listar", result: result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao listar!", error: error.message });
				}
			}

			findOneBy = async (req: Request, res: Response) => {
				try {
					const operation: Partial<Operation> = { id: Number(req.params.id) };

					const result = await this.operationService.findOneBy(operation);

					if (!result) {
						res.status(404).json({ message: "Sucesso ao consultar!", result: 'Nenhum um registro encontrado!' });
						return;
					}

					res.status(200).json({ message: "Sucesso ao consultar!", result: result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao consultar!", error: error.message });
				}
			}

			update = async (req: Request, res: Response) => {
				try {
					const operation: Operation = { id: Number(req.params.id), ...req.body };

					const result = await this.operationService.update(operation);

					res.status(200).json({ message: "Sucesso ao atualizar!", result: result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao atualizar!", error: error.message });
				}
			}

			delete = async (req: Request, res: Response) => {
				try {
					const id = Number(req.params.id);

					const result = await this.operationService.delete(id);

					res.status(200).json({ message: "Sucesso ao deletar!", result: result });
				}
				catch (error: any) {
					res.status(500).json({ message: "Erro ao deletar!", error: error.message });
				}
			}

		}
	EOF

	mkdir src/operation -p
	touch src/operation/operationRouter.ts
	code src/operation/operationRouter.ts
	cat <<- EOF > src/operation/operationRouter.ts
		import { Router } from 'express';
		import { UserController } from './userController';
		import { UserRepository } from './userRepository';
		import { UserService } from './userService';
		import { DataSource } from 'typeorm';

		export class UserRouter {
			private userRepository: UserRepository;
			private userService: UserService;
			private userController: UserController;
			private router: Router;
			
			constructor(dataSource: DataSource) {
				this.userRepository = new UserRepository(dataSource);
				this.userService = new UserService(this.userRepository);
				this.userController = new UserController(this.userService);

				this.router = Router();

				this.router.post('/', this.userController.save);
				this.router.get('/', this.userController.find);
				this.router.get('/:id', this.userController.findOneBy);
				this.router.put('/:id', this.userController.update);
				this.router.delete('/:id', this.userController.delete);
			}

			get routes() {
				return this.router;
			}

			get service (){
				return this.userService;
			}
		}
	EOF

	mkdir src -p
	touch src/index.ts
	code src/index.ts
	cat <<- EOF > src/index.ts
		import express from 'express';

		import { dataSource } from './data/dataSource';
		import { userRouter } from './user/userRouter';

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

			app.use("/user", userRouter);

			app.listen(3000, () => {
				console.log('Sucesso ao iniciar servidor!');
			})
			.on('error', (error) => {
				console.error('Erro ao iniciar servidor!', error);
				process.exit(1);
			});

		})();
	EOF