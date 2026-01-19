import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/home/controllers/home_controller.dart';
import 'package:quizzie/features/home/controllers/profile_controller.dart';
import 'package:quizzie/features/home/screens/history_screen.dart';
import 'package:quizzie/features/home/screens/profile_screen.dart';
import 'package:quizzie/features/questions/screens/quiz_screen.dart';
import 'package:quizzie/features/questions/screens/result_screen.dart';
import 'package:quizzie/utils/assets.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';
import 'package:intl/intl.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final PageController pageController = PageController();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // body: PageView(
      //   controller: pageController,
      //   onPageChanged: (index) {
      //     homeController.getselectedIndex(index);
      //   },
      //   children: [
      //     _buildHomeTab(context), // Home tab
      //     _buildCategoriesTab(),
      //     ProfileScreen(), // Profile tab
      //   ],
      // ),
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            // Optional: nice scale + fade effect
            // transitionBuilder: (child, animation) => ScaleTransition(
            //   scale: Tween<double>(begin: 0.92, end: 1.0).animate(animation),
            //   child: FadeTransition(opacity: animation, child: child),
            // ),
            child: IndexedStack(
              key: ValueKey<int>(
                  homeController.selectedIndex), // ← very important!
              index: homeController.selectedIndex,
              children: [
                _buildHomeTab(context),
                _buildCategoriesTab(),
                ProfileScreen(),
              ],
            ),
          )),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Obx(
        () => Row(
          children: [
            if (homeController.selectedIndex == 0) ...[
              _buildHomeTitle()
            ] else if (homeController.selectedIndex == 1) ...[
              Text(
                'Categories',
                style: header4.copyWith(
                    fontWeight: FontWeight.w800, color: QZColor.headerColor),
              ),
            ] else ...[
              Text(
                'Profile',
                style: header4.copyWith(
                    fontWeight: FontWeight.w800, color: QZColor.headerColor),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTitle() {
    return GestureDetector(
      onTap: () {
        homeController.getselectedIndex(2);
        // pageController.animateToPage(
        //   2,
        //   duration: const Duration(milliseconds: 400),
        //   curve: Curves.easeInOut,
        // );
      },
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Icon(
              Icons.person,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileController.userInfo['name'] ?? '',
                style: header4.copyWith(
                    fontWeight: FontWeight.w800, color: QZColor.headerColor),
              ),
              Text(
                'ID - ${profileController.userInfo['_id']}',
                style: header8.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.blueGrey),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: homeController.selectedIndex,
        selectedItemColor: QZColor.headerColor,
        unselectedItemColor: const Color.fromARGB(255, 61, 57, 57),
        selectedLabelStyle: header6.copyWith(
            fontWeight: FontWeight.w600, color: QZColor.headerColor),
        unselectedLabelStyle:
            header6.copyWith(fontWeight: FontWeight.w400, color: Colors.grey),
        onTap: (index) {
          homeController.getselectedIndex(index);
          // pageController.animateToPage(
          //   index,
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeInOut,
          // );
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              DTIcons.homeIcon,
              height: 20,
              width: 20,
              color: homeController.selectedIndex == 0
                  ? QZColor.headerColor
                  : Colors.grey,
            ),
            label: homeController.isSelected == 'ENGLISH' ? 'Home' : 'गृहपृष्ठ',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              DTIcons.categoriesIcon,
              height: 20,
              width: 20,
              color: homeController.selectedIndex == 1
                  ? QZColor.headerColor
                  : Colors.grey,
            ),
            label: homeController.isSelected == 'ENGLISH'
                ? 'Categories'
                : 'श्रेणी',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              DTIcons.profileIcon,
              height: 20,
              width: 20,
              color: homeController.selectedIndex == 2
                  ? QZColor.headerColor
                  : Colors.grey,
            ),
            label:
                homeController.isSelected == 'ENGLISH' ? 'Profile' : 'प्रोफाइल',
          ),
        ],
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
            _buildHeroBanner(context),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: header5.copyWith(
                      fontWeight: FontWeight.w700, color: QZColor.headerColor),
                ),
                GestureDetector(
                  onTap: () {
                    homeController.getselectedIndex(1);
                    // pageController.animateToPage(
                    //   1,
                    //   duration: const Duration(milliseconds: 200),
                    //   curve: Curves.easeInOut,
                    // );
                  },
                  child: Text(
                    'View All >',
                    style: header7.copyWith(
                        fontWeight: FontWeight.w700, color: QZColor.color2),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: homeController.quizType.length > 5
                    ? 5
                    : homeController.quizType.length,
                itemBuilder: (context, index) {
                  final quizType = homeController.quizType[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: _buildQuizContainer(
                      onTap: () => Get.to(() => QuizScreen(
                          quizType: quizType['_id'],
                          quizName: quizType['name'])),
                      text: quizType['name'],
                      icon: _buildCategoryIcon(quizType['name']),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: header5.copyWith(
                      fontWeight: FontWeight.w700, color: QZColor.headerColor),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => HistoryScreen()),
                  child: Text(
                    'View All >',
                    style: header7.copyWith(
                        fontWeight: FontWeight.w700, color: QZColor.color2),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Obx(() {
              if (homeController.recentResults.isEmpty) {
                return Center(child: Image.asset(DTImages.noActivityImage));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeController.recentResults.length > 5
                      ? 5
                      : homeController.recentResults.length,
                  itemBuilder: (context, index) {
                    final item = homeController.recentResults[index];
                    final formattedDate = DateFormat.yMMMd().add_jm().format(
                          DateTime.parse(item['timestamp']),
                        );
                    return GestureDetector(
                      onTap: () => Get.to(() => ResultScreen(
                          result: Map<String, dynamic>.from(item))),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 60,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white, // needed for shadow to appear
                            boxShadow: [
                              BoxShadow(
                                color: QZColor.headerColor.withOpacity(0.5),
                                spreadRadius: 1, // how much the shadow spreads
                                blurRadius: 6, // softness of the shadow
                                offset: Offset(0, 3), // x and y offset
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    _buildCategoryIcon(item['quizName']),
                                    height: 35,
                                    width: 35,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${item['quizName']} ',
                                        style: header6.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(formattedDate,
                                          style: header7.copyWith(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  homeController.deleteResult(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: homeController.quizType.length,
          itemBuilder: (context, index) {
            final quizType = homeController.quizType[index];
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => QuizScreen(
                          quizName: quizType['name'],
                          quizType: quizType['_id'],
                        ));
                  },
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: QZColor.headerColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              _buildCategoryIcon(quizType['name']),
                              height: 35,
                              width: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              quizType['name'],
                              style: header6.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ),
      ],
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF153A6F),
            Color(0xFF0D2B57),
          ],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/trophy.png'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              'Test Your Knowledge with\nQuizzes',
              style: header3.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Text(
              "You're just looking for a playful way to learn new facts, our quizzes are designed to entertain and educate.",
              style: header8.copyWith(
                color: Colors.white.withOpacity(0.85),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF153A6F),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              final mixedType = homeController.quizType
                  .firstWhere((e) => e['name'] == 'Mixed');

              Get.to(() => QuizScreen(
                    quizName: mixedType['name'],
                    quizType: mixedType['_id'],
                  ));
            },
            child: Text(
              'Play Now',
              style: header6.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizContainer({
    required void Function()? onTap,
    required String text,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: SvgPicture.asset(
              icon,
              height: 18,
              width: 18,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 60, //  restrict text width to icon width
            child: Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: header8.copyWith(
                color: Colors.black,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildCategoryIcon(String text) {
    if (text == 'Science') {
      return DTIcons.scienceIcon;
    } else if (text == 'Maths') {
      return DTIcons.mathsIcon;
    } else if (text == 'Sports') {
      return DTIcons.sportsIcon;
    } else if (text == 'History') {
      return DTIcons.historyIcon;
    } else if (text == 'Geography') {
      return DTIcons.geographyIcon;
    } else if (text == 'Computer') {
      return DTIcons.computerIcon;
    } else if (text == 'General knowledge') {
      return DTIcons.gkIcon;
    }
    return DTIcons.mixedIcon;
  }
}
