import express from 'express';
import { submitResult } from '../controllers/resultController.js';

/**
 * @swagger
 * /api/results:
 *   post:
 *     summary: Submit quiz result
 *     tags: [Results]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: string
 *               quizId:
 *                 type: string
 *               score:
 *                 type: number
 *     responses:
 *       201:
 *         description: Result saved
 */


const router = express.Router();

router.post('/', submitResult);

export default router;
