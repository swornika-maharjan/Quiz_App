import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/controllers/questions_controller.dart';

class ResultScreen extends StatelessWidget {
  final String quizType;
  ResultScreen({super.key, required this.quizType});

  final QuestionsController questionsController = Get.put(
    QuestionsController(),
  );

  @override
  Widget build(BuildContext context) {
    final quizData = questionsController.getQuizData(quizType);
    final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${quizType}_results'.tr,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: ${questionsController.score}/${questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final questionId = question['id'];
                  final userAnswer =
                      questionsController.selectedAnswers[questionId];
                  final correctAnswer =
                      question['options'][question['answerIndex']];
                  final isCorrect =
                      questionsController.answerResults[questionId] ?? false;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${question['id']}. ${question['question']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Your Answer: ${userAnswer ?? "Not answered"}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          if (!isCorrect)
                            Text(
                              'Correct Answer: $correctAnswer',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: MaterialButton(
          color: Colors.indigo,
          height: 50,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            questionsController.resetQuiz();
            Get.back();
          },
          child: Text(
            'try_again'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
