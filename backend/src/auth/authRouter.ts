import { Router } from 'express';

import { authController } from './authController';
import { authMiddleware } from './authMiddleware';

export const authRouter = Router();
authRouter.use(authMiddleware.autenticar);
authRouter.post("/", authController.logar);
