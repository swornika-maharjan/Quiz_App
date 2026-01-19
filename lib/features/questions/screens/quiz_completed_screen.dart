import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/home/controllers/profile_controller.dart';
import 'package:quizzie/features/home/screens/home_page_screen.dart';
import 'package:quizzie/features/questions/screens/result_screen.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';

class QuizCompletedScreen extends StatelessWidget {
  QuizCompletedScreen({
    super.key,
    required this.index,
    required this.questions,
    required this.result,
  });

  final int index;
  final int questions;
  final Map<String, dynamic>? result;
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: QZColor.headerColor,
                border: Border.all(
                  color: Colors.indigo,
                  width: 10,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Your score',
                        style: header2.copyWith(
                            fontWeight: FontWeight.w400, color: QZColor.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${result?['score']}',
                            style: header2.copyWith(
                                fontWeight: FontWeight.w800,
                                color: QZColor.white)),
                        const SizedBox(height: 4),
                        Text(' / $questions',
                            style: header2.copyWith(
                                fontWeight: FontWeight.w800,
                                color: QZColor.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
                result?['score'] <= 5
                    ? 'Oops 🫢!'
                    : result?['score'] <= 12
                        ? 'Not bad 😉!'
                        : 'Congratulation! 🎉',
                style: header2.copyWith(
                    fontWeight: FontWeight.w600, color: QZColor.headerColor)),
            Text(
                result?['score'] <= 5
                    ? 'Better luck next time'
                    : result?['score'] <= 12
                        ? 'Good job, ${profileController.userInfo['name'] ?? ''} ! You can do better'
                        : 'Excellent , ${profileController.userInfo['name'] ?? ''} ! You Did It',
                style: header5.copyWith(
                    fontWeight: FontWeight.w400, color: QZColor.headerColor)),
            const SizedBox(height: 200),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ResultScreen(
                        result: result ?? {},
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.indigo, // 👈 key line
                  disabledForegroundColor: Colors.white, // 👈 key line
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View Result',
                  style: header6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(() => HomePageScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.indigo, // 👈 key line
                  disabledForegroundColor: Colors.white, // 👈 key line
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Back to Home',
                  style: header6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
