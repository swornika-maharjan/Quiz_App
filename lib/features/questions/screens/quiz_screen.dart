import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizzie/features/questions/controllers/questions_controller.dart';
import 'package:quizzie/features/questions/screens/result_screen.dart';
import 'package:quizzie/notification/notification_service.dart';
import '../../home/controllers/theme_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class QuizScreen extends StatelessWidget {
  final String quizType;
  QuizScreen({super.key, required this.quizType});

  final QuestionsController questionsController = Get.put(
    QuestionsController(),
  );
  final ThemeController themeController = Get.put(ThemeController());
  final RxBool isSubmitted = false.obs;

  @override
  Widget build(BuildContext context) {
    questionsController.setQuizType(quizType);

    final quizData = questionsController.getQuizData(quizType);
    final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${quizType}_questions'.tr,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: Colors.grey),
        ),
      ),
      // body: Obx(() {
      //   if (questions.isEmpty) {
      //     return const Center(child: Text("No questions found."));
      //   }

      //   final index = questionsController.currentQuestionIndex.value;
      //   final question = questions[index];
      //   final questionId = question['_id'];
      //   final selected = questionsController.selectedAnswers[questionId];

      //   return Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         LinearProgressIndicator(
      //           borderRadius: BorderRadius.circular(5),
      //           minHeight: 10,
      //           value: (index + 1) / questions.length,
      //           backgroundColor: Colors.grey.shade300,
      //           color: Colors.indigo,
      //         ),
      //         const SizedBox(height: 20),
      //         Text(
      //           "Question ${index + 1}/${questions.length}",
      //           style: const TextStyle(
      //             fontWeight: FontWeight.w600,
      //             fontSize: 14,
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //         AnimatedContainer(
      //           duration: const Duration(milliseconds: 200),
      //           curve: Curves.easeOut,
      //           padding: const EdgeInsets.all(16),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(15),
      //             color: Colors.blueGrey[50],
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.blue.withOpacity(0.3),
      //                 blurRadius: 8,
      //                 offset: const Offset(3, 3),
      //               ),
      //               BoxShadow(
      //                 color: Colors.grey.withOpacity(0.8),
      //                 blurRadius: 6,
      //                 offset: const Offset(-4, -4),
      //               ),
      //             ],
      //           ),
      //           child: Column(
      //             children: [
      //               Text(
      //                 question['questionText'],
      //                 style: const TextStyle(
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.w600,
      //                 ),
      //               ),
      //               const SizedBox(height: 20),
      //               ...List.generate((question['options'] as List).length, (i) {
      //                 final option = question['options'][i];
      //                 final isSelected = selected == option;

      //                 return GestureDetector(
      //                   onTap: () {
      //                     // Save the selected answer
      //                     questionsController.toggleRadioButton(
      //                       questionId,
      //                       option,
      //                     );

      //                     // Move to next question immediately
      //                     Future.delayed(const Duration(milliseconds: 200), () {
      //                       if (questionsController.currentQuestionIndex.value <
      //                           questions.length - 1) {
      //                         questionsController.currentQuestionIndex.value++;
      //                       }
      //                     });
      //                   },
      //                   child: AnimatedContainer(
      //                     duration: const Duration(milliseconds: 200),
      //                     margin: const EdgeInsets.symmetric(vertical: 8),
      //                     padding: const EdgeInsets.all(14),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(12),
      //                       color: isSelected
      //                           ? Colors.indigo.shade100
      //                           : Colors.lime[50],
      //                       border: Border.all(
      //                         color: isSelected
      //                             ? Colors.indigo
      //                             : Colors.grey.shade300,
      //                         width: 1.5,
      //                       ),
      //                       boxShadow: [
      //                         BoxShadow(
      //                           color: Colors.grey.withOpacity(0.15),
      //                           blurRadius: 6,
      //                           offset: const Offset(2, 2),
      //                         ),
      //                       ],
      //                     ),
      //                     child: Row(
      //                       children: [
      //                         Text(
      //                           option,
      //                           style: TextStyle(
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w500,
      //                             color: isSelected
      //                                 ? Colors.indigo.shade900
      //                                 : Colors.black87,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               }),
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 24),
      //         if (index == questions.length - 1)
      //           MaterialButton(
      //             color: Colors.indigo,
      //             height: 50,
      //             minWidth: double.infinity,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             onPressed: () async {
      //               questionsController.compareCorrectAnswers(quizType);
      //               final result = {
      //                 'quizType': quizType,
      //                 'questions': questions,
      //                 'selectedAnswers': questionsController.selectedAnswers
      //                     .map((key, value) => MapEntry(key.toString(), value)),
      //                 'answerResults': questionsController.answerResults.map(
      //                   (key, value) => MapEntry(key.toString(), value),
      //                 ),
      //                 'score': questionsController.score,
      //                 'total': questions.length,
      //                 'timestamp': DateTime.now().toString(),
      //               };

      //               final box = Hive.box('quiz_results');
      //               final List history = box.get('results', defaultValue: []);
      //               history.add(result);
      //               await box.put('results', history);

      //               await NotificationService.flutterLocalNotificationsPlugin
      //                   .show(
      //                 0,
      //                 '🎉 Quiz Completed!',
      //                 'You’ve completed the quiz successfully!',
      //                 const NotificationDetails(
      //                   android: AndroidNotificationDetails(
      //                     'quiz_channel',
      //                     'Quiz Notifications',
      //                     importance: Importance.high,
      //                     priority: Priority.high,
      //                   ),
      //                 ),
      //               );

      //               Get.to(() => ResultScreen(result: result));
      //             },
      //             child: Text(
      //               'Submit'.tr,
      //               style: const TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w600,
      //                 fontSize: 14,
      //               ),
      //             ),
      //           ),
      //       ],
      //     ),
      //   );
      // }),
      body: Builder(
        builder: (_) {
          final quizData = questionsController.getQuizData(quizType);
          final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

          if (questions.isEmpty) {
            return const Center(child: Text("No questions found."));
          }

          return Obx(() {
            final index = questionsController.currentQuestionIndex.value;
            final question = questions[index];
            final questionId = question['_id'];
            final selected = questionsController.selectedAnswers[questionId];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(5),
                    minHeight: 10,
                    value: (index + 1) / questions.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Question ${index + 1}/${questions.length}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(3, 3),
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 6,
                          offset: const Offset(-4, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          question['questionText'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...List.generate((question['options'] as List).length,
                            (i) {
                          final option = question['options'][i];
                          final isSelected = selected == option;

                          return GestureDetector(
                            onTap: () {
                              // Save the selected answer
                              questionsController.toggleRadioButton(
                                questionId,
                                option,
                              );

                              // Move to next question immediately
                              Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                if (questionsController
                                        .currentQuestionIndex.value <
                                    questions.length - 1) {
                                  questionsController
                                      .currentQuestionIndex.value++;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isSelected
                                    ? Colors.indigo.shade100
                                    : Colors.lime[50],
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.indigo
                                      : Colors.grey.shade300,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.indigo.shade900
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  if (index == questions.length - 1)
                    MaterialButton(
                      color: Colors.indigo,
                      height: 50,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        questionsController.compareCorrectAnswers(quizType);
                        final result = {
                          'quizType': quizType,
                          'questions': questions,
                          'selectedAnswers': questionsController.selectedAnswers
                              .map((key, value) =>
                                  MapEntry(key.toString(), value)),
                          'answerResults':
                              questionsController.answerResults.map(
                            (key, value) => MapEntry(key.toString(), value),
                          ),
                          'score': questionsController.score,
                          'total': questions.length,
                          'timestamp': DateTime.now().toString(),
                        };

                        final box = Hive.box('quiz_results');
                        final List history =
                            box.get('results', defaultValue: []);
                        history.add(result);
                        await box.put('results', history);

                        await NotificationService
                            .flutterLocalNotificationsPlugin
                            .show(
                          0,
                          '🎉 Quiz Completed!',
                          'You’ve completed the quiz successfully!',
                          const NotificationDetails(
                            android: AndroidNotificationDetails(
                              'quiz_channel',
                              'Quiz Notifications',
                              importance: Importance.high,
                              priority: Priority.high,
                            ),
                          ),
                        );

                        Get.to(() => ResultScreen(result: result));
                      },
                      child: Text(
                        'Submit'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
