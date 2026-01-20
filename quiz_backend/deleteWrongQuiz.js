import mongoose from 'mongoose';
import dotenv from 'dotenv';
import Quiz from './models/quizModel.js';
import connectDB from './config/db.js';

// Load .env variables
dotenv.config();

// Connect to MongoDB
connectDB();

mongoose.connection.once('open', async () => {
  console.log('Connected to MongoDB');

  // Delete the wrong quiz
  const result = await Quiz.deleteOne({ title: "Sample Quiz" });
  if (result.deletedCount > 0) {
    console.log("Wrong quiz deleted!");
  } else {
    console.log("No quiz found with that title.");
  }

  mongoose.connection.close();
});
