import Result from '../models/resultModel.js';

export const submitResult = async (req, res) => {
  try {
    const { userId, quizId, score } = req.body;
    const result = await Result.create({ userId, quizId, score });
    res.status(201).json({ message: 'Result submitted successfully', result });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
