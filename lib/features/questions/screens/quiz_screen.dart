import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizzie/features/home/controllers/home_controller.dart';
import 'package:quizzie/features/questions/controllers/questions_controller.dart';
import 'package:quizzie/features/questions/screens/quiz_completed_screen.dart';
import 'package:quizzie/features/questions/screens/result_screen.dart';
import 'package:quizzie/notification/notification_service.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';
import '../../home/controllers/theme_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class QuizScreen extends StatelessWidget {
  final String quizType;
  final String quizName;
  QuizScreen({super.key, required this.quizType, required this.quizName});

  final QuestionsController questionsController = Get.put(
    QuestionsController(),
  );
  final ThemeController themeController = Get.put(ThemeController());
  final RxBool isSubmitted = false.obs;
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    questionsController.setQuizType(quizType);
    final quizData = questionsController.getQuizData(quizType);
    final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '$quizName Questions',
              style: header6.copyWith(
                  color: QZColor.headerColor, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              ' (${questions.length} questions)',
              style: header7.copyWith(
                  color: Colors.grey, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        // bottom: const PreferredSize(
        //   preferredSize: Size.fromHeight(1),
        //   child: Divider(color: Colors.grey),
        // ),
      ),
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
            final String questionId = question['_id']?.toString() ??
                question['questionText'] ??
                'q_$index';
            final selected = questionsController.selectedAnswers[questionId];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircularProgressIndicator(

                  //   value: (index + 1) / questions.length,
                  //   backgroundColor: Colors.grey.shade300,
                  //   color: Colors.indigo,
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   "Question ${index + 1}/${questions.length}",
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 14,
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question: ${index + 1}/${questions.length}",
                          style: header8.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: QZColor.headerColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          question['questionText'] ?? 'No Question Text',
                          style: header4.copyWith(
                            fontWeight: FontWeight.w600,
                            color: QZColor.headerColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...List.generate(
                            ((question['options'] ?? []) as List).length, (i) {
                          final option = question['options']?[i] ?? '';
                          final isSelected = selected == option;

                          return GestureDetector(
                            onTap: () {
                              // Save the selected answer
                              questionsController.toggleRadioButton(
                                questionId,
                                option,
                              );

                              // // Move to next question immediately
                              // Future.delayed(const Duration(milliseconds: 200),
                              //     () {
                              //   if (questionsController
                              //           .currentQuestionIndex.value <
                              //       questions.length - 1) {
                              //     questionsController
                              //         .currentQuestionIndex.value++;
                              //   }
                              // });
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
                  // if (index == questions.length - 1)
                  //   MaterialButton(
                  //     color: Colors.indigo,
                  //     height: 50,
                  //     minWidth: double.infinity,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     // onPressed: () async {
                  //     //   questionsController.compareCorrectAnswers(quizType);
                  //     //   final result = {
                  //     //     'quizType': quizType,
                  //     //     'quizName': quizName,
                  //     //     'questions': questions,
                  //     //     'selectedAnswers': questionsController.selectedAnswers
                  //     //         .map((key, value) =>
                  //     //             MapEntry(key.toString(), value)),
                  //     //     'answerResults':
                  //     //         questionsController.answerResults.map(
                  //     //       (key, value) => MapEntry(key.toString(), value),
                  //     //     ),
                  //     //     'score': questionsController.score,
                  //     //     'total': questions.length,
                  //     //     'timestamp': DateTime.now().toString(),
                  //     //   };

                  //     //   final box = Hive.box('quiz_results');
                  //     //   final List history =
                  //     //       box.get('results', defaultValue: []);
                  //     //   history.add(result);
                  //     //   await box.put('results', history);

                  //     //   await NotificationService
                  //     //       .flutterLocalNotificationsPlugin
                  //     //       .show(
                  //     //     0,
                  //     //     '🎉 Quiz Completed!',
                  //     //     'You’ve completed the quiz successfully!',
                  //     //     const NotificationDetails(
                  //     //       android: AndroidNotificationDetails(
                  //     //         'quiz_channel',
                  //     //         'Quiz Notifications',
                  //     //         importance: Importance.high,
                  //     //         priority: Priority.high,
                  //     //       ),
                  //     //     ),
                  //     //   );

                  //     //   Get.to(() => ResultScreen(result: result));
                  //     // },
                  //     onPressed: () async {
                  //       questionsController.compareCorrectAnswers(quizType);
                  //       final result = {
                  //         'quizType': quizType,
                  //         'quizName': quizName,
                  //         'questions': questions,
                  //         'selectedAnswers': questionsController.selectedAnswers
                  //             .map((key, value) =>
                  //                 MapEntry(key.toString(), value)),
                  //         'answerResults':
                  //             questionsController.answerResults.map(
                  //           (key, value) => MapEntry(key.toString(), value),
                  //         ),
                  //         'score': questionsController.score,
                  //         'total': questions.length,
                  //         'timestamp': DateTime.now().toIso8601String(),
                  //       };

                  //       homeController.addResult(result);

                  //       await NotificationService
                  //           .flutterLocalNotificationsPlugin
                  //           .show(
                  //         0,
                  //         '🎉 Quiz Completed!',
                  //         'You’ve completed the quiz successfully!',
                  //         const NotificationDetails(
                  //           android: AndroidNotificationDetails(
                  //             'quiz_channel',
                  //             'Quiz Notifications',
                  //             importance: Importance.high,
                  //             priority: Priority.high,
                  //           ),
                  //         ),
                  //       );

                  //       Get.to(() => ResultScreen(result: result));
                  //     },
                  //     child: Text(
                  //       'Submit'.tr,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //   ),
                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // PREVIOUS BUTTON
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: index == 0
                              ? null
                              : () {
                                  questionsController.previousQuestion();
                                },
                          style: quizNavButtonStyle,
                          child: Text(
                            'Previous',
                            style: header7.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // NEXT OR SUBMIT BUTTON
                      index == questions.length - 1
                          ? SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () async {
                                  questionsController
                                      .compareCorrectAnswers(quizType);

                                  final result = {
                                    'quizType': quizType,
                                    'quizName': quizName,
                                    'questions': questions,
                                    'selectedAnswers': questionsController
                                        .selectedAnswers
                                        .map((k, v) =>
                                            MapEntry(k.toString(), v)),
                                    'answerResults': questionsController
                                        .answerResults
                                        .map((k, v) =>
                                            MapEntry(k.toString(), v)),
                                    'score': questionsController.score,
                                    'total': questions.length,
                                    'timestamp':
                                        DateTime.now().toIso8601String(),
                                  };

                                  homeController.addResult(result);

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

                                  // Get.to(() => ResultScreen(result: result));
                                  Get.to(() => QuizCompletedScreen(
                                        index: index,
                                        questions: questions.length,
                                        result: result,
                                      ));
                                },
                                style: quizNavButtonStyle,
                                child: Text(
                                  'Submit',
                                  style: header7.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  questionsController
                                      .nextQuestion(questions.length);
                                },
                                style: quizNavButtonStyle,
                                child: Text(
                                  'Next',
                                  style: header7.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  final ButtonStyle quizNavButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    disabledBackgroundColor: Colors.indigo, // 👈 key line
    disabledForegroundColor: Colors.white, // 👈 key line
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
