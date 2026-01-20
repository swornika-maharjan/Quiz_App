import mongoose from "mongoose";

const QuizSchema = new mongoose.Schema({
  title: String,
  description: String,
  quizTypeId: { type: mongoose.Schema.Types.ObjectId, ref: "QuizType" },
  questions: [
    {
      questionText: String,
      options: [String],
      correctAnswer: String
    }
  ]
});

export default mongoose.model("Quiz", QuizSchema);
