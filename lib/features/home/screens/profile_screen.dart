import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie/features/home/controllers/home_controller.dart';
import 'package:quizzie/features/home/controllers/profile_controller.dart';
import 'package:quizzie/features/home/controllers/theme_controller.dart';
import 'package:quizzie/features/home/screens/history_screen.dart';
import 'package:quizzie/utils/colors.dart';
import 'package:quizzie/utils/styles.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final ThemeController themeController = Get.put(ThemeController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Profile',
      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      //   ),
      //   bottom: const PreferredSize(
      //     preferredSize: Size.fromHeight(1),
      //     child: Divider(),
      //   ),
      // ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Profile Info ---
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: QZColor.grey, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: QZColor.headerColor.withOpacity(0.5),
                            spreadRadius: 1, // how much the shadow spreads
                            blurRadius: 6, // softness of the shadow
                            offset: Offset(0, 3), // x and y offset
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person, size: 90),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profileController.userInfo['name'] ?? '',
                      style: header4.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.indigoAccent),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'ID No: ${profileController.userInfo['_id'] ?? ''}',
                      style: header8.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'settings'.tr,
                style: header5.copyWith(
                    fontWeight: FontWeight.w700, color: QZColor.headerColor),
              ),
              const SizedBox(height: 10),

              /// --- Language ListTile ---
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'language'.tr,
                  style: header7.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.blueGrey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                onTap: () => _showLanguageOptions(context),
              ),
              const Divider(),

              /// --- History ListTile ---
              // ListTile(
              //   dense: true,
              //   contentPadding: EdgeInsets.zero,
              //   title: Text(
              //     'history'.tr,
              //     style: header5.copyWith(
              //         color: Colors.grey, fontWeight: FontWeight.w400),
              //   ),
              //   trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              //   onTap: () => Get.to(() => HistoryScreen()),
              // ),
              // const Divider(),

              /// --- Theme ListTile ---
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'theme'.tr,
                  style: header7.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.blueGrey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                onTap: () => _showThemeOptions(context),
              ),
              Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            homeController.logout();
          },
          child: Container(
            height: 44,
            decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: QZColor.grey.withOpacity(0.2))),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_outlined,
                  size: 20,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Log out',
                  style: header5.copyWith(color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// --- Language Bottom Sheet ---
  void _showLanguageOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language'.tr,
                style: header5.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: QZColor.headerColor,
                ),
              ),
              const SizedBox(height: 12),
              _languageTile(
                title: 'english'.tr,
                value: 'ENGLISH',
              ),
              _languageTile(
                title: 'nepali'.tr,
                value: 'NEPALI',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageTile({
    required String title,
    required String value,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: header6.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Radio<String>(
        value: value,
        groupValue: homeController.isSelected,
        activeColor: QZColor.headerColor,
        onChanged: (val) {
          if (val != null) {
            homeController.toggleTranslation(val);
            homeController.changeLanguage(val);
            // Get.back();
          }
        },
      ),
      onTap: () {
        homeController.toggleTranslation(value);
        homeController.changeLanguage(value);
        // Get.back();
      },
    );
  }

  /// --- Theme Bottom Sheet ---
  void _showThemeOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Theme'.tr,
                style: header5.copyWith(
                  fontWeight: FontWeight.w700,
                  color: QZColor.headerColor,
                ),
              ),
              const SizedBox(height: 12),
              _themeTile(
                title: 'system_default'.tr,
                value: AppThemeMode.system,
              ),
              _themeTile(
                title: 'light_mode'.tr,
                value: AppThemeMode.light,
              ),
              _themeTile(
                title: 'dark_mode'.tr,
                value: AppThemeMode.dark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themeTile({
    required String title,
    required AppThemeMode value,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: header6.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Radio<AppThemeMode>(
        value: value,
        groupValue: themeController.themeMode,
        activeColor: QZColor.headerColor,
        onChanged: (val) {
          if (val != null) {
            themeController.changeTheme(val);
            // Get.back();
          }
        },
      ),
      onTap: () {
        themeController.changeTheme(value);
        // Get.back();
      },
    );
  }
}
