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
  bool showQuizLogo = false;
  bool moveToTop = false;
  bool showButton = false;

  late AnimationController _appearController;
  late AnimationController _wheelController;

  // Bounce in
  late Animation<double> _appearYOffset;
  late Animation<double> _appearScale;

  // Smooth wheel animation
  late Animation<double> _wheelRotation;
  late Animation<double> _wheelScale;
  late Animation<double> _wheelYOffset;

  @override
  void initState() {
    super.initState();

    // 1️⃣ Initial bounce
    _appearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _appearYOffset = Tween<double>(begin: 14, end: 0).animate(
      CurvedAnimation(parent: _appearController, curve: Curves.easeOutBack),
    );

    _appearScale = Tween<double>(begin: 0.96, end: 1.0).animate(
      CurvedAnimation(parent: _appearController, curve: Curves.easeOutBack),
    );

    // 2️⃣ Wheel animation (180° → pause → back)
    _wheelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400), // total duration
    );

    _wheelRotation = TweenSequence<double>([
      // Step 1: rotate 0 → 0.5 (180°) in first 40% of total duration
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: 40),
      // Step 2: pause at 180° (no rotation) for next 20%
      TweenSequenceItem(tween: ConstantTween<double>(0.4), weight: 90),
      // Step 3: rotate back 0.5 → 0 in last 40%
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: _wheelController, curve: Curves.easeInOutCubic),
    );

// Slight scale up and down during rotation
    _wheelScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 40),
      TweenSequenceItem(tween: ConstantTween<double>(1.15), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: _wheelController, curve: Curves.easeInOutCubic),
    );

// Vertical offset bounce
    _wheelYOffset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -6.0), weight: 40),
      TweenSequenceItem(tween: ConstantTween<double>(-6.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 0.0), weight: 40),
    ]).animate(
      CurvedAnimation(parent: _wheelController, curve: Curves.easeInOutCubic),
    );

    _startAnimationSequence();
  }

  @override
  void dispose() {
    _appearController.dispose();
    _wheelController.dispose();
    super.dispose();
  }

  Future<void> _startAnimationSequence() async {
    // Small initial delay
    await Future.delayed(const Duration(milliseconds: 250));
    if (!mounted) return;
    setState(() => showIcons = true);

    // Step 1: Bounce in
    await _appearController.forward();

    // Step 2: Tiny pause
    await Future.delayed(const Duration(milliseconds: 120));

    // Step 3: One smooth wheel animation
    await _wheelController.forward();

    // Step 4: Show logo + gradient
    await Future.delayed(const Duration(milliseconds: 180));
    if (!mounted) return;
    setState(() {
      showQuizLogo = true;
      showGradient = true;
    });

    // Step 5: Move icons up
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => moveToTop = true);

    // Step 6: Show star + button
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
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
              // Splash2 icon (just static)
              // Positioned(
              //   child: Image.asset(
              //     DTImages.splash2Icon,
              //     height: 90,
              //   ),
              // ),

              // Quiz logo
              AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                alignment: showQuizLogo
                    ? Alignment(0.4, moveToTop ? -0.3 : 0.0)
                    : const Alignment(0.0, 0.0),
                child: AnimatedOpacity(
                  opacity: showQuizLogo ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    DTImages.quizLogo,
                    height: 70,
                  ),
                ),
              ),

              // Splash icon (main wheel)
              AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                alignment: showQuizLogo
                    ? Alignment(-0.3, moveToTop ? -0.3 : 0.0)
                    : const Alignment(0.0, 0.0),
                child: AnimatedBuilder(
                  animation:
                      Listenable.merge([_appearController, _wheelController]),
                  builder: (_, __) {
                    return Transform.translate(
                      offset:
                          Offset(0, _appearYOffset.value + _wheelYOffset.value),
                      child: Transform.scale(
                        scale: _appearScale.value * _wheelScale.value,
                        child: RotationTransition(
                          turns: _wheelRotation,
                          child: Image.asset(
                            DTImages.splashIcon,
                            height: 70,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // Star icon
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
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

            // Get Started button
            AnimatedAlign(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: AnimatedOpacity(
                  opacity: showButton ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    height: 50,
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QZColor.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.offAll(
                          () => const LoginScreen(),
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
                          const SizedBox(width: 6),
                          Text(
                            "Get Started",
                            style: header5.copyWith(
                              fontWeight: FontWeight.w700,
                              color: QZColor.white,
                            ),
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
