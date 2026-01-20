import express from 'express';
import { createQuiz, getQuizzes } from '../controllers/quizController.js';

const router = express.Router();

/**
 * @swagger
 * components:
 *   schemas:
 *     Question:
 *       type: object
 *       properties:
 *         questionText:
 *           type: string
 *           example: What is H2O?
 *         options:
 *           type: array
 *           items:
 *             type: string
 *           example: ["Water", "Oxygen", "Hydrogen"]
 *         correctAnswer:
 *           type: string
 *           example: Water
 *     QuizType:
 *       type: object
 *       properties:
 *         _id:
 *           type: string
 *         name:
 *           type: string
 *         description:
 *           type: string
 *     Quiz:
 *       type: object
 *       properties:
 *         _id:
 *           type: string
 *         title:
 *           type: string
 *           example: Sample Quiz
 *         description:
 *           type: string
 *           example: A test quiz
 *         quizType:
 *           $ref: '#/components/schemas/QuizType'
 *         questions:
 *           type: array
 *           items:
 *             $ref: '#/components/schemas/Question'
 */

/**
 * @swagger
 * /api/quizzes:
 *   get:
 *     summary: Get all quizzes with populated quiz type
 *     tags: [Quizzes]
 *     responses:
 *       200:
 *         description: List of quizzes
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Quiz'
 */

/**
 * @swagger
 * /api/quizzes:
 *   post:
 *     summary: Create a new quiz
 *     tags: [Quizzes]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *               description:
 *                 type: string
 *               quizTypeId:
 *                 type: string
 *                 description: ID of the quiz type
 *               questions:
 *                 type: array
 *                 items:
 *                   $ref: '#/components/schemas/Question'
 *     responses:
 *       201:
 *         description: Quiz created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Quiz'
 */

router.get('/', getQuizzes);
router.post('/', createQuiz);


export default router;
