import mongoose from "mongoose";

const QuizTypeSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  description: {
    type: String,
    default: ""
  }
});

export default mongoose.model("QuizType", QuizTypeSchema);
