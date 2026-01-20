import QuizType from "../models/quizTypeModel.js";

export const getQuizTypes = async (req, res) => {
  try {
    const quizTypes = await QuizType.find();
    res.status(200).json(quizTypes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const createQuizTypes = async (req, res) => {
  try {
    const { name, description } = req.body;

    if (!name) return res.status(400).json({ message: "Quiz type name is required" });

    const quizType = await QuizType.create({ name, description });

    res.status(201).json({
      message: "Quiz type created successfully",
      quizType
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};


