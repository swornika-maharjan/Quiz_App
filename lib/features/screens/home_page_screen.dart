import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/controllers/questions_controller.dart';
import 'package:quizzie/features/controllers/theme_controller.dart';
import 'package:quizzie/features/screens/history_screen.dart';
import 'package:quizzie/features/screens/profile_screen.dart';
import 'package:quizzie/features/screens/questions/quiz_screen.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});
  final QuestionsController questionsController = Get.put(
    QuestionsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerDragStartBehavior: DragStartBehavior.start,
      drawerEdgeDragWidth: 50,
      drawer: Scaffold(
        appBar: AppBar(
          actionsPadding: const EdgeInsets.only(right: 16),
          title: Text(
            'quizzie'.tr,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GetBuilder<ThemeController>(
            builder: (themeController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => HistoryScreen()),
                    child: Text(
                      'history'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'theme'.tr,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  RadioListTile<AppThemeMode>(
                    value: AppThemeMode.system,
                    groupValue: themeController.themeMode,
                    title: Text(
                      'system_default'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (val) => themeController.changeTheme(val!),
                  ),
                  RadioListTile<AppThemeMode>(
                    value: AppThemeMode.light,
                    groupValue: themeController.themeMode,
                    title: Text(
                      'light_mode'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (val) => themeController.changeTheme(val!),
                  ),
                  RadioListTile<AppThemeMode>(
                    value: AppThemeMode.dark,
                    groupValue: themeController.themeMode,
                    title: Text(
                      'dark_mode'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (val) => themeController.changeTheme(val!),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(10),
        actions: [
          // SvgPicture.asset(
          //   'assets/icons/notification.svg',
          //   color: Theme.of(context).textTheme.bodyMedium?.color,
          // ),
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
          child: Divider(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'mixed')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'mixed_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'history')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'history_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'science')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'science_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'geography')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'geography_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'math')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'math_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'cs')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'computer_science'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'sports')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'sports_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: () => Get.to(() => QuizScreen(quizType: 'literature')),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'literature_knowledge_quiz'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: questionsController.selectedIndex,
          onTap: (value) {
            questionsController.getselectedIndex(value);
            switch (value) {
              case 0:
                // Get.to(() => const MedicalBookScreen());
                break;
              case 1:
                Get.to(() => ProfileScreen());
                break;
            }
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: questionsController.isSelected == 'ENGLISH'
                  ? 'Home'
                  : 'गृहपृष्ठ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: questionsController.isSelected == 'ENGLISH'
                  ? 'Profile'
                  : 'प्रोफाइल',
            ),
          ],
        ),
      ),
    );
  }
}
