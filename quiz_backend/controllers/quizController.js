import Quiz from '../models/quizModel.js';



// @desc Create new quiz or replace questions if quiz for the same quizTypeId exists
export const createQuiz = async (req, res) => {
try {
const { title, description, quizTypeId, questions } = req.body;


// Find quiz by quizTypeId
let quiz = await Quiz.findOne({ quizTypeId });

if (quiz) {
  // Replace old questions and update other fields
  quiz.title = title; // update title if needed
  quiz.description = description;
  quiz.questions = questions; // overwrite old questions
  await quiz.save();
} else {
  // Create a new quiz
  quiz = await Quiz.create({ title, description, quizTypeId, questions });
}

// Populate quizTypeId for response
const populatedQuiz = await Quiz.findById(quiz._id).populate("quizTypeId", "name description");

res.status(200).json({
  message: 'Quiz created/updated successfully',
  quiz: populatedQuiz
});


} catch (error) {
res.status(500).json({ message: error.message });
}
};





// @desc Get all quizzes
export const getQuizzes = async (req, res) => {
try {
const quizzes = await Quiz.find().populate("quizTypeId", "name description");

// Format response: rename quizTypeId → quizType
const formattedQuizzes = quizzes.map(q => ({
  _id: q._id,
  title: q.title,
  description: q.description,
  quizType: q.quizTypeId, // populated object
  questions: q.questions
}));

res.status(200).json(formattedQuizzes);

} catch (error) {
res.status(500).json({ message: error.message });
}
};
