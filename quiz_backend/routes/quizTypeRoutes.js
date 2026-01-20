import express from "express";
import { getQuizTypes, createQuizTypes } from "../controllers/quizTypeController.js";

const router = express.Router();
/**
 * @swagger
 * /api/quiz-types:
 *   get:
 *     summary: Get all quiz types
 *     tags: [Quiz Types]
 *     responses:
 *       200:
 *         description: List of quiz types
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   _id:
 *                     type: string
 *                   name:
 *                     type: string
 *                   description:
 *                     type: string
 *                     example: "Covers a wide range of topics from everyday life, history, geography, and culture."
 */

/**
 * @swagger
 * /api/quiz-types:
 *   post:
 *     summary: Create a new quiz type
 *     tags: [Quiz Types]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: "Science"
 *               description:
 *                 type: string
 *                 example: "Covers physics, chemistry, biology, and related topics."
 *     responses:
 *       201:
 *         description: Quiz type created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Quiz type created successfully"
 *                 quizType:
 *                   type: object
 *                   properties:
 *                     _id:
 *                       type: string
 *                     name:
 *                       type: string
 *                     description:
 *                       type: string
 */



router.get("/", getQuizTypes);
router.post("/", createQuizTypes);

export default router;
