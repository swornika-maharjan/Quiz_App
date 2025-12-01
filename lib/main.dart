import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quizzie/api-service/api_service.dart';
import 'package:quizzie/features/auth/screens/login_screen.dart';
import 'package:quizzie/features/home/controllers/theme_controller.dart';
import 'package:quizzie/features/home/screens/home_page_screen.dart';
import 'package:quizzie/features/questions/controllers/questions_controller.dart';
import 'package:quizzie/features/splash_screen.dart';
import 'package:quizzie/notification/notification_service.dart';
// import 'package:quizzie/notification/notification_service.dart';
import 'package:quizzie/utils/translation.dart';

// Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  await Hive.openBox('quiz_results');
  await Hive.openBox('authBox');

  // Handle messages when the app is in the background or terminated
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.requestNotificationPermission();
  NotificationService().initializeNotifications();

  // Restore JWT token if exists
  var authBox = Hive.box('authBox');
  final savedToken = authBox.get('token');
  if (savedToken != null) {
    RESTExecutor.setToken(savedToken);
    print("RESTExecutor token restored: $savedToken");
  }

  Get.put(ThemeController());
  Get.put(QuestionsController());
  runApp(MyApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Hive.openBox('quiz_results'),
        Hive.openBox('authBox'),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return const MyApp();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());

  final locale = const Locale('en', 'US');

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    getToken();
    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the message
      print("Received message: ${message.notification?.title}");
    });
  }

  void getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Request notification permissions
    _firebaseMessaging.requestPermission();
    var box = Hive.box('authBox');
    String? token = box.get('token');

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
        home: token != null ? HomePageScreen() : SplashScreen(),
      ),
    );
  }
}
