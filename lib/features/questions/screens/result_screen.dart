import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/questions/controllers/questions_controller.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';

class ResultScreen extends StatelessWidget {
  // final String quizType;
  final Map<String, dynamic> result;
  ResultScreen({super.key, required this.result});

  final QuestionsController questionsController = Get.put(
    QuestionsController(),
  );
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // final quizType = result['quizType'];
    final quizName = result['quizName'];
    final questions = result['questions'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$quizName Results',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Score: ${result['score']}/${result['questions'].length}',
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
                  final String questionId = question['_id']?.toString() ?? question['questionText'] ?? 'q_$index';
                  final selectedAnswers = Map<String, dynamic>.from(
                    result['selectedAnswers'],
                  );
                  final answerResults = Map<String, dynamic>.from(
                    result['answerResults'],
                  );

                  final userAnswer = selectedAnswers[questionId];
                  final isCorrect = answerResults[questionId] ?? false;

                  final correctAnswer = question['correctAnswer'];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   width: double.infinity,
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 10, horizontal: 16),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     color: Colors.indigo.withOpacity(0.1),
                          //   ),
                          //   child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}. ${question['questionText']}',
                                style: header5.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: QZColor.headerColor),
                              ),
                            ],
                          ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: isCorrect
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                'Your Answer: ${userAnswer ?? "Not answered"}',
                                style: header7.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isCorrect ? Colors.green : Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (!isCorrect)
                            Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Correct Answer: $correctAnswer',
                                  style: header7.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.green),
                                ),
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
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      //   child: MaterialButton(
      //     color: Colors.indigo,
      //     height: 50,
      //     shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     onPressed: () {
      //       questionsController.resetQuiz();
      //       Get.back();
      //     },
      //     child: Text(
      //       'try_again'.tr,
      //       style: const TextStyle(
      //         fontWeight: FontWeight.w600,
      //         fontSize: 13,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
