import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/screens/result_screen.dart';

import '../../controllers/questions_controller.dart';
import '../../controllers/theme_controller.dart';

class QuizScreen extends StatelessWidget {
  final String quizType; // e.g., 'history', 'science', 'geography'
  QuizScreen({super.key, required this.quizType});

  final QuestionsController questionsController = Get.put(
    QuestionsController(),
  );
  final ThemeController themeController = Get.put(ThemeController());
  final RxBool isSubmitted = false.obs;

  @override
  Widget build(BuildContext context) {
    // Set the quiz type in the controller
    questionsController.setQuizType(quizType);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${quizType}_questions'.tr,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actionsPadding: const EdgeInsets.all(10),
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                questionsController.showOptions(context);
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  questionsController.isSelected,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: Colors.grey),
        ),
      ),
      body: Obx(() {
        final quizData = questionsController.getQuizData(quizType);
        final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: List.generate(questions.length, (index) {
                final question = questions[index];
                final questionId = question['id'];
                final selected =
                    questionsController.selectedAnswers[questionId];
                final isCorrect = questionsController.answerResults[questionId];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: List.generate(
                          (question['options'] as List).length,
                          (i) {
                            final option = question['options'][i];
                            final optionLabel = String.fromCharCode(65 + i);
                            final isCorrectOption =
                                i == question['answerIndex'];
                            final isSelectedOption = selected == option;

                            return RadioMenuButton<String>(
                              value: option,
                              groupValue: selected,
                              onChanged: isSubmitted.value
                                  ? null
                                  : (value) {
                                      questionsController.toggleRadioButton(
                                        questionId,
                                        value!,
                                      );
                                    },
                              child: Text(
                                '$optionLabel. $option',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSubmitted.value
                                      ? (isSelectedOption && isCorrect!
                                            ? Colors.red
                                            : isCorrectOption
                                            ? Colors.green
                                            : Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color ??
                                                  Colors.black)
                                      : Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.color ??
                                            Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: MaterialButton(
          color: Colors.indigo,
          height: 50,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            final quizData = questionsController.getQuizData(quizType);
            final questions = quizData[0]['questions'];
            if (questionsController.selectedAnswers.length < questions.length) {
              Get.snackbar('Error', 'Please answer all questions');
              return;
            }

            if (!isSubmitted.value) {
              isSubmitted.value = true;
              questionsController.compareCorrectAnswers(quizType);
              Get.to(() => ResultScreen(quizType: quizType));
            }
          },
          child: Text(
            'submit'.tr,
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
