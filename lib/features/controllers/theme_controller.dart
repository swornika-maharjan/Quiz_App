// lib/features/controllers/theme_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppThemeMode { system, light, dark }

class ThemeController extends GetxController {
  final Rx<AppThemeMode> _themeMode = AppThemeMode.system.obs;

  AppThemeMode get themeMode => _themeMode.value;

  ThemeMode get currentThemeMode {
    switch (_themeMode.value) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  void changeTheme(AppThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(currentThemeMode);
  }
}
