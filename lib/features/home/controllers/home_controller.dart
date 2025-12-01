import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quizzie/api-service/api_service.dart';
import 'package:quizzie/features/auth/screens/login_screen.dart';

class HomeController extends GetxController {
  final RxString _isSelected = 'ENGLISH'.obs;
  final RxInt _selectedIndex = 0.obs;
  final RxList _quizType = [].obs;
  final RxBool _isLoading = false.obs;

  //getter
  String get isSelected => _isSelected.value;
  int get selectedIndex => _selectedIndex.value;
  List get quizType => _quizType;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchQuizTypes();
  }

  void toggleTranslation(String value) {
    _isSelected.value = value;
  }

  void changeLanguage(String langCode) {
    var locale = Locale(langCode == 'NEPALI' ? 'ne' : 'en', 'US');
    Get.updateLocale(locale);
  }

  void getselectedIndex(int value) {
    _selectedIndex.value = value;
  }

  void logout() {
    var box = Hive.box('authBox');
    box.delete('token');
    Get.offAll(() => LoginScreen());
  }

  Future<void> fetchQuizTypes() async {
    _isLoading(true);
    RESTExecutor(
        domain: 'quizzes',
        label: 'quiz-type-list',
        method: 'GET',
        successCallback: (res) {
          print('Success:  $res');
          final result = res ?? [];
          _quizType.assignAll(result);
          _isLoading(false);
        },
        errorCallback: (err) {
          _isLoading(false);
          Get.snackbar('Error', err['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }).execute();
  }
}
