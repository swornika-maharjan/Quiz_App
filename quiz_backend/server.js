import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './config/db.js';
import userRoutes from './routes/userRoutes.js';
import quizRoutes from './routes/quizRoutes.js';
import resultRoutes from './routes/resultRoutes.js';
import { swaggerUi, swaggerSpec } from './swagger.js';
import quizTypeRoutes from './routes/quizTypeRoutes.js';



dotenv.config();
console.log("Loaded MONGO_URI:", process.env.MONGO_URI);

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Connect to DB
connectDB();


// Routes
app.use('/api/users', userRoutes);
app.use('/api/quizzes', quizRoutes);
app.use('/api/results', resultRoutes);
app.use('/api/quiz-types', quizTypeRoutes);

const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  console.log('✅ Root route hit');
  res.send('✅ Quiz Backend API is running...');
});



app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
