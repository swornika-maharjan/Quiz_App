import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/auth/screens/login_screen.dart';
import 'package:quizzie/utils/assets.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool showGradient = false;
  bool showIcons = false;
  bool showSplashIcon = false;
  bool showQuizLogo = false;
  bool moveToTop = false;
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  Future<void> _startAnimationSequence() async {
    // Step 1: white screen, show initial splash icon
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      showIcons = true;
      showSplashIcon = true;
    });

    // Step 2: transition to splash2 icon on white background
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => showSplashIcon = false);

    // Wait for transition to splash2
    await Future.delayed(const Duration(milliseconds: 900));

    // Step 3: transition back to splash icon
    setState(() => showSplashIcon = true);

    // Wait for transition back to splash
    await Future.delayed(const Duration(milliseconds: 600));

    // Step 4: display quiz logo and start gradient
    setState(() {
      showQuizLogo = true;
      showGradient = true;
    });

    // Wait for logo slide and gradient animation to complete
    await Future.delayed(const Duration(milliseconds: 800));

    // Step 5: move icons and logo a little bit top
    setState(() => moveToTop = true);

    // Wait for move to top animation
    await Future.delayed(const Duration(milliseconds: 600));

    // Step 6: show star icon and button
    setState(() => showButton = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          gradient: showGradient
              ? QZColor.linearGradient
              : const LinearGradient(colors: [Colors.white, Colors.white]),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (showIcons) ...[
              // Splash2 Icon (fades in/out during transitions, fixed at center)
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: AnimatedOpacity(
                  opacity: showSplashIcon ? 0 : 1,
                  duration: const Duration(milliseconds: 600),
                  child: Image.asset(
                    DTImages.splash2Icon,
                    height: 90,
                  ),
                ),
              ),

              // Quiz logo slides in from behind (from left to right position)
              AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                alignment: showQuizLogo
                    ? Alignment(0.4, moveToTop ? -0.3 : 0.0)
                    : Alignment(-0.0, moveToTop ? -0.2 : 0.0),
                child: AnimatedOpacity(
                  opacity: showQuizLogo ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  child: Image.asset(
                    DTImages.quizLogo,
                    height: 70,
                  ),
                ),
              ),

              // Splash Icon (fades in/out during transitions, moves later)
              AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                alignment: showQuizLogo
                    ? Alignment(-0.3, moveToTop ? -0.3 : 0.0)
                    : Alignment(0.0, moveToTop ? -0.2 : 0.0),
                child: AnimatedOpacity(
                  opacity: showSplashIcon ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  child: Image.asset(
                    DTImages.splashIcon,
                    height: 70,
                  ),
                ),
              ),
            ],

            // Star icon on top, shown when button is displayed
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: AnimatedOpacity(
                  opacity: showButton ? 1 : 0,
                  duration: const Duration(milliseconds: 600),
                  child: Image.asset(
                    DTImages.starIcon,
                    height: 220,
                  ),
                ),
              ),
            ),

            // Bottom Get Started button
            AnimatedAlign(
              duration: const Duration(milliseconds: 800),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: showButton ? 1 : 0,
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QZColor.buttonColor,
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.offAll(
                          () => LoginScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 900),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            DTIcons.playIcon,
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Get Started",
                            style: header5.copyWith(
                                fontWeight: FontWeight.w700,
                                color: QZColor.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
