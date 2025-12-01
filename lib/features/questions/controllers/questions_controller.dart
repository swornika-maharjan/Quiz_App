import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie/api-service/api_service.dart';

class QuestionsController extends GetxController {
  final RxMap<String, String> selectedAnswers = <String, String>{}.obs;
  final RxMap<String, bool> _answerResults = <String, bool>{}.obs;

  final RxInt _score = 0.obs;
  final RxString _currentQuizType = 'mixed'.obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxBool _isLoading = false.obs;
  final RxList _quizData = [].obs;

  //getter
  Map<String, bool> get answerResults => _answerResults;
  int get score => _score.value;
  String get currentQuizType => _currentQuizType.value;
  bool get isLoading => _isLoading.value;
  List get quizData => _quizData;

  @override
  void onInit() {
    super.onInit();
    fetchQuizQuestion();
  }

  // Get quiz data based on quiz type
  List getQuizData(String quizType) {
    return _quizData.where((e) => e['quizType']['_id'] == quizType).toList();
  }

  // List getQuizData(String quizType) {
  //   return _quizData; // always return API list
  // }

  void setQuizType(String quizType) {
    _currentQuizType.value = quizType;
    resetQuiz();
  }

  void toggleRadioButton(String questionId, String selectedOption) {
    selectedAnswers[questionId] = selectedOption;
  }

  void compareCorrectAnswers(String quizType) {
    _score.value = 0;
    _answerResults.clear();

    final quizData = getQuizData(quizType);
    final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

    for (var question in questions) {
      final questionId = question['_id'];
      final correctAnswer = question['correctAnswer'];
      final userAnswer = selectedAnswers[questionId];

      if (userAnswer != null) {
        final isCorrect = userAnswer == correctAnswer;
        _answerResults[questionId] = isCorrect;
        if (isCorrect) _score.value++;
      } else {
        _answerResults[questionId] = false;
      }
    }
  }

  void resetQuiz() {
    selectedAnswers.clear();
    _answerResults.clear();
    _score.value = 0;
    currentQuestionIndex.value = 0;
  }

  Future<void> fetchQuizQuestion() async {
    _isLoading(true);
    RESTExecutor(
        domain: 'quizzes',
        label: 'quiz-questions-list',
        method: 'GET',
        successCallback: (res) {
          print('Success $res');
          final result = res ?? [];
          _quizData.assignAll(result);

          _isLoading(false);
        },
        errorCallback: (err) {
          _isLoading(false);
          print('Error: ${err['message']}');
          Get.snackbar('Error', err['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }).execute();
  }
}
