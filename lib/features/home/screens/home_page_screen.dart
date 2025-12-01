import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/home/controllers/home_controller.dart';
import 'package:quizzie/features/home/screens/history_screen.dart';
import 'package:quizzie/features/home/screens/profile_screen.dart';
import 'package:quizzie/features/questions/screens/quiz_screen.dart';
import 'package:quizzie/utils/styles.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: Drawer(
          width: 300,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'quizzie'.tr,
                style: header2.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear)),
                )
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
                    onTap: () {
                      Get.to(() => HistoryScreen());
                    },
                    child: Container(
                      height: 44,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.history),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'history'.tr,
                            style: header6.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        appBar: homeController.selectedIndex == 0
            ? AppBar(
                title: Text(
                  'quizzie'.tr,
                  style: header2.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.deepPurple,
                  ),
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(),
                ),
              )
            : null,
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            homeController.getselectedIndex(index);
          },
          children: [
            _buildHomeTab(context), // Home tab
            ProfileScreen(), // Profile tab
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeController.selectedIndex,
          onTap: (index) {
            homeController.getselectedIndex(index);
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label:
                  homeController.isSelected == 'ENGLISH' ? 'Home' : 'गृहपृष्ठ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: homeController.isSelected == 'ENGLISH'
                  ? 'Profile'
                  : 'प्रोफाइल',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's Play ",
              style: header3.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.purpleAccent,
              ),
            ),
            Text(
              'Be the first!',
              style: header5.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[1400],
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeController.quizType.length,
              itemBuilder: (context, index) {
                final quizType = homeController.quizType[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildQuizContainer(
                    onTap: () =>
                        Get.to(() => QuizScreen(quizType: quizType['_id'])),
                    text: quizType['name'],
                    description: quizType['description'],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuizContainer(
      {required void Function()? onTap,
      required String text,
      required String description}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 16),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 3,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 6,
              offset: const Offset(-4, -4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.tr,
              style: header4.copyWith(
                color: Colors.black,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              description,
              style: header6.copyWith(
                color: Colors.grey,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
