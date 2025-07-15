import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  final RxList _quizData = [
    {
      "quizTitle": "Mixed Knowledge Quiz",
      "category": "Mixed",
      "questions": [
        {
          "id": 1,
          "question": "What is the capital of Japan?",
          "options": ["Tokyo", "Seoul", "Beijing", "Bangkok"],
          "answerIndex": 0,
        },
        {
          "id": 2,
          "question": "Who painted the Mona Lisa?",
          "options": ["Van Gogh", "Picasso", "Da Vinci", "Rembrandt"],
          "answerIndex": 2,
        },
        {
          "id": 3,
          "question": "Which planet is closest to the Sun?",
          "options": ["Venus", "Mercury", "Earth", "Mars"],
          "answerIndex": 1,
        },
        {
          "id": 4,
          "question": "In what year did World War II end?",
          "options": ["1945", "1939", "1940", "1950"],
          "answerIndex": 0,
        },
        {
          "id": 5,
          "question": "What is the largest mammal?",
          "options": ["Elephant", "Blue Whale", "Giraffe", "Hippopotamus"],
          "answerIndex": 1,
        },
        {
          "id": 6,
          "question": "Which language is primarily spoken in Brazil?",
          "options": ["Spanish", "Portuguese", "French", "Italian"],
          "answerIndex": 1,
        },
        {
          "id": 7,
          "question": "What is the chemical symbol for gold?",
          "options": ["Gd", "Ag", "Au", "Pb"],
          "answerIndex": 2,
        },
        {
          "id": 8,
          "question": "Who invented the telephone?",
          "options": [
            "Thomas Edison",
            "Alexander Graham Bell",
            "Newton",
            "Tesla",
          ],
          "answerIndex": 1,
        },
        {
          "id": 9,
          "question": "Which country hosted the 2016 Summer Olympics?",
          "options": ["China", "UK", "Brazil", "Japan"],
          "answerIndex": 2,
        },
        {
          "id": 10,
          "question": "What is H2O commonly known as?",
          "options": ["Salt", "Water", "Hydrogen", "Oxygen"],
          "answerIndex": 1,
        },
        {
          "id": 11,
          "question": "Which is the smallest prime number?",
          "options": ["0", "1", "2", "3"],
          "answerIndex": 2,
        },
        {
          "id": 12,
          "question": "What is the hardest natural substance?",
          "options": ["Gold", "Iron", "Diamond", "Silver"],
          "answerIndex": 2,
        },
        {
          "id": 13,
          "question": "Which continent is Egypt located in?",
          "options": ["Asia", "Europe", "Africa", "Australia"],
          "answerIndex": 2,
        },
        {
          "id": 14,
          "question": "What does DNA stand for?",
          "options": [
            "Digital Network Array",
            "Deoxyribonucleic Acid",
            "Data Node Algorithm",
            "Dynamic Network Architecture",
          ],
          "answerIndex": 1,
        },
        {
          "id": 15,
          "question": "Which organ pumps blood through the body?",
          "options": ["Liver", "Lungs", "Heart", "Kidney"],
          "answerIndex": 2,
        },
        {
          "id": 16,
          "question": "Who was the first man on the moon?",
          "options": [
            "Buzz Aldrin",
            "Neil Armstrong",
            "Yuri Gagarin",
            "John Glenn",
          ],
          "answerIndex": 1,
        },
        {
          "id": 17,
          "question": "What is the tallest mountain in the world?",
          "options": ["K2", "Mount Everest", "Kangchenjunga", "Makalu"],
          "answerIndex": 1,
        },
        {
          "id": 18,
          "question": "What is the boiling point of water at sea level?",
          "options": ["100°C", "90°C", "80°C", "70°C"],
          "answerIndex": 0,
        },
        {
          "id": 19,
          "question": "What currency is used in the UK?",
          "options": ["Dollar", "Euro", "Pound", "Yen"],
          "answerIndex": 2,
        },
        {
          "id": 20,
          "question": "Which gas do humans breathe in for survival?",
          "options": ["Carbon Dioxide", "Oxygen", "Nitrogen", "Helium"],
          "answerIndex": 1,
        },
      ],
    },
  ].obs;

  final RxList _scienceQuizData = [
    {
      "quizTitle": "Basic Science Quiz",
      "category": "Science",
      "questions": [
        {
          "id": 1,
          "question": "What planet is known as the Red Planet?",
          "options": ["Mars", "Jupiter", "Saturn", "Venus"],
          "answerIndex": 0,
        },
        {
          "id": 2,
          "question": "What gas do plants absorb from the atmosphere?",
          "options": ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"],
          "answerIndex": 1,
        },
        {
          "id": 3,
          "question": "What part of the cell contains DNA?",
          "options": ["Mitochondria", "Cytoplasm", "Nucleus", "Cell Wall"],
          "answerIndex": 2,
        },
        {
          "id": 4,
          "question": "Which human organ produces insulin?",
          "options": ["Liver", "Heart", "Pancreas", "Lungs"],
          "answerIndex": 2,
        },
        {
          "id": 5,
          "question": "What is the chemical symbol for oxygen?",
          "options": ["Ox", "O", "Oy", "O2"],
          "answerIndex": 1,
        },
      ],
    },
  ].obs;

  final RxList _geographyQuizData = [
    {
      "quizTitle": "World Geography Quiz",
      "category": "Geography",
      "questions": [
        {
          "id": 1,
          "question": "Which is the longest river in the world?",
          "options": ["Amazon", "Yangtze", "Nile", "Mississippi"],
          "answerIndex": 2,
        },
        {
          "id": 2,
          "question":
              "Which ocean lies on the east coast of the United States?",
          "options": ["Pacific", "Arctic", "Atlantic", "Indian"],
          "answerIndex": 2,
        },
        {
          "id": 3,
          "question": "Which desert is the largest in the world?",
          "options": ["Gobi", "Sahara", "Kalahari", "Arabian"],
          "answerIndex": 1,
        },
        {
          "id": 4,
          "question": "Mount Kilimanjaro is located in which country?",
          "options": ["Kenya", "Tanzania", "Uganda", "South Africa"],
          "answerIndex": 1,
        },
        {
          "id": 5,
          "question": "Which country has the most number of time zones?",
          "options": ["USA", "Russia", "China", "France"],
          "answerIndex": 3,
        },
      ],
    },
  ].obs;

  final RxList _historyQuizData = [
    {
      "quizTitle": "World History Quiz",
      "category": "History",
      "questions": [
        {
          "id": 1,
          "question": "Who was the first President of the United States?",
          "options": [
            "George Washington",
            "Thomas Jefferson",
            "Lincoln",
            "Adams",
          ],
          "answerIndex": 0,
        },
        {
          "id": 2,
          "question": "What ancient civilization built the pyramids?",
          "options": ["Romans", "Greeks", "Egyptians", "Babylonians"],
          "answerIndex": 2,
        },
        {
          "id": 3,
          "question":
              "The Great Wall of China was built to protect against which group?",
          "options": ["Romans", "Huns", "Mongols", "Persians"],
          "answerIndex": 2,
        },
        {
          "id": 4,
          "question": "Who discovered America in 1492?",
          "options": ["Columbus", "Vasco da Gama", "Magellan", "Cook"],
          "answerIndex": 0,
        },
        {
          "id": 5,
          "question": "Which empire was ruled by Julius Caesar?",
          "options": ["Greek", "Roman", "Ottoman", "Byzantine"],
          "answerIndex": 1,
        },
      ],
    },
  ].obs;

  final RxList _mathQuizData = [
    {
      "quizTitle": "Basic Mathematics Quiz",
      "category": "Math",
      "questions": [
        {
          "id": 1,
          "question": "What is 7 × 8?",
          "options": ["54", "56", "64", "58"],
          "answerIndex": 1,
        },
        {
          "id": 2,
          "question": "What is the square root of 144?",
          "options": ["12", "14", "16", "10"],
          "answerIndex": 0,
        },
        {
          "id": 3,
          "question": "What is 15% of 200?",
          "options": ["25", "30", "35", "40"],
          "answerIndex": 1,
        },
        {
          "id": 4,
          "question": "What is the value of π (pi) up to two decimal places?",
          "options": ["3.12", "3.14", "3.16", "3.18"],
          "answerIndex": 1,
        },
        {
          "id": 5,
          "question": "What is 9²?",
          "options": ["81", "72", "99", "89"],
          "answerIndex": 0,
        },
      ],
    },
  ].obs;

  final RxList _csQuizData = [
    {
      "quizTitle": "Computer Science Quiz",
      "category": "Computer Science",
      "questions": [
        {
          "id": 1,
          "question": "What does CPU stand for?",
          "options": [
            "Central Processing Unit",
            "Control Panel Unit",
            "Computer Program Unit",
            "Central Program Unit",
          ],
          "answerIndex": 0,
        },
        {
          "id": 2,
          "question": "Which language is used to build Android apps?",
          "options": ["Java", "Python", "Swift", "C#"],
          "answerIndex": 0,
        },
        {
          "id": 3,
          "question": "Which company developed the Windows OS?",
          "options": ["Google", "Apple", "Microsoft", "IBM"],
          "answerIndex": 2,
        },
        {
          "id": 4,
          "question": "What is the full form of HTML?",
          "options": [
            "HyperText Markup Language",
            "HighText Machine Language",
            "HyperText Machine Language",
            "None of the above",
          ],
          "answerIndex": 0,
        },
        {
          "id": 5,
          "question": "What is the shortcut for 'Copy' in most systems?",
          "options": ["Ctrl + V", "Ctrl + C", "Ctrl + X", "Ctrl + P"],
          "answerIndex": 1,
        },
      ],
    },
  ].obs;

  final RxList _sportsQuizData = [
    {
      "quizTitle": "World Sports Quiz",
      "category": "Sports",
      "questions": [
        {
          "id": 1,
          "question":
              "How many players are there in a football team (on field)?",
          "options": ["10", "11", "12", "9"],
          "answerIndex": 1,
        },
        {
          "id": 2,
          "question": "Which country has won the most FIFA World Cups?",
          "options": ["Germany", "Italy", "Brazil", "Argentina"],
          "answerIndex": 2,
        },
        {
          "id": 3,
          "question": "In which sport is a shuttlecock used?",
          "options": ["Tennis", "Squash", "Badminton", "Cricket"],
          "answerIndex": 2,
        },
        {
          "id": 4,
          "question": "Which sport is associated with Wimbledon?",
          "options": ["Golf", "Tennis", "Cricket", "Football"],
          "answerIndex": 1,
        },
        {
          "id": 5,
          "question": "How many rings are there in the Olympic symbol?",
          "options": ["4", "5", "6", "7"],
          "answerIndex": 1,
        },
      ],
    },
  ].obs;

  final RxList _literatureQuizData = [
    {
      "quizTitle": "Classic Literature Quiz",
      "category": "Literature",
      "questions": [
        {
          "id": 1,
          "question": "Who wrote 'Romeo and Juliet'?",
          "options": [
            "Charles Dickens",
            "William Shakespeare",
            "Jane Austen",
            "Mark Twain",
          ],
          "answerIndex": 1,
        },
        {
          "id": 2,
          "question": "Which novel features the character 'Sherlock Holmes'?",
          "options": [
            "Dracula",
            "The Hound of the Baskervilles",
            "Oliver Twist",
            "Frankenstein",
          ],
          "answerIndex": 1,
        },
        {
          "id": 3,
          "question": "'Animal Farm' was written by which author?",
          "options": [
            "George Orwell",
            "Ernest Hemingway",
            "Aldous Huxley",
            "J.K. Rowling",
          ],
          "answerIndex": 0,
        },
        {
          "id": 4,
          "question": "Who is the author of 'Pride and Prejudice'?",
          "options": [
            "Emily Bronte",
            "Jane Austen",
            "Virginia Woolf",
            "George Eliot",
          ],
          "answerIndex": 1,
        },
        {
          "id": 5,
          "question": "What is the genre of 'The Hobbit'?",
          "options": ["Science Fiction", "Fantasy", "Drama", "Romance"],
          "answerIndex": 1,
        },
      ],
    },
  ].obs;

  final RxString _isSelected = 'ENGLISH'.obs;
  final RxInt _selectedIndex = 0.obs;
  final RxMap<int, String> selectedAnswers = <int, String>{}.obs;
  final RxMap<int, bool> _answerResults = <int, bool>{}.obs;
  final RxInt _score = 0.obs;
  final RxString _currentQuizType = 'mixed'.obs;

  //getter
  List get quizData => _quizData;
  List get scienceQuizData => _scienceQuizData;
  List get geographyQuizData => _geographyQuizData;
  List get historyQuizData => _historyQuizData;
  String get isSelected => _isSelected.value;
  int get selectedIndex => _selectedIndex.value;
  Map<int, bool> get answerResults => _answerResults;
  int get score => _score.value;
  String get currentQuizType => _currentQuizType.value;
  List get mathQuizData => _mathQuizData;
  List get csQuizData => _csQuizData;
  List get sportsQuizData => _sportsQuizData;
  List get literatureQuizData => _literatureQuizData;

  // Get quiz data based on quiz type
  List getQuizData(String quizType) {
    switch (quizType) {
      case 'science':
        return _scienceQuizData;
      case 'geography':
        return _geographyQuizData;
      case 'history':
        return _historyQuizData;
      case 'math':
        return _mathQuizData;
      case 'cs':
        return _csQuizData;
      case 'sports':
        return _sportsQuizData;
      case 'literature':
        return _literatureQuizData;
      default:
        return _quizData;
    }
  }

  void setQuizType(String quizType) {
    _currentQuizType.value = quizType;
    resetQuiz();
  }

  void toggleRadioButton(int questionId, String selectedOption) {
    selectedAnswers[questionId] = selectedOption;
  }

  void showOptions(BuildContext context) async {
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 80, 0, 0),
      items: [
        PopupMenuItem<String>(value: 'NEPALI', child: Text('NEPALI')),
        PopupMenuItem<String>(value: 'ENGLISH', child: Text('ENGLISH')),
      ],
    );

    if (selected != null && selected != _isSelected.value) {
      toggleTranslation(selected);
      changeLanguage(selected);
    }
  }

  void toggleTranslation(String value) {
    _isSelected.value = value;
    selectedAnswers.clear();
  }

  void changeLanguage(String langCode) {
    var locale = Locale(langCode == 'NEPALI' ? 'ne' : 'en', 'US');
    Get.updateLocale(locale);
  }

  void getselectedIndex(int value) {
    _selectedIndex.value = value;
  }

  void compareCorrectAnswers(String quizType) {
    _score.value = 0;
    _answerResults.clear();

    final quizData = getQuizData(quizType);
    final questions = quizData.isNotEmpty ? quizData[0]['questions'] : [];

    for (var question in questions) {
      final questionId = question['id'];
      final correctAnswer = question['options'][question['answerIndex']];
      final userAnswer = selectedAnswers[questionId];

      if (userAnswer != null) {
        _answerResults[questionId] = userAnswer == correctAnswer;
        if (_answerResults[questionId]!) {
          _score.value++;
        }
      } else {
        _answerResults[questionId] == false;
      }
    }
  }

  void resetQuiz() {
    selectedAnswers.clear();
    _answerResults.clear();
    _score.value = 0;
  }
}
