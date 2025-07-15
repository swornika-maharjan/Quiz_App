import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/controllers/questions_controller.dart';
import 'package:quiz_app/features/controllers/theme_controller.dart';
import 'package:quiz_app/features/screens/home_page_screen.dart';
import 'package:quiz_app/translation.dart';

void main() {
  Get.put(ThemeController());
  Get.put(QuestionsController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());
  final locale = const Locale('en', 'US');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Quizzie',
        translations: AppTranslations(),
        locale: locale,
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [Locale('en', 'US'), Locale('ne', 'NP')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.currentThemeMode,
        home: HomePageScreen(),
      ),
    );
  }
}
