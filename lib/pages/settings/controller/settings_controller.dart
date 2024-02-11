import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/database/db_helper.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  // Observable variables to hold the settings
  Rx<bool> isLightMode = true.obs;
  Rx<bool> reminderAt = false.obs;
  Rx<bool> addPercentage = false.obs;
  Rx<TextStyle> textSemiBold14 = const TextStyle().obs;
@override
  void onInit() {
    getSavedSettings();
    ever(isLightMode, (_) {
      updateTextStyle();
    });
    super.onInit();
  }
  void updateTextStyle() {
    textSemiBold14.value = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: isLightMode.value ? Colors.white : Colors.black87,
    );
  }
  // Method to toggle the theme setting
  void toggleTheme() {
    isLightMode.value = !isLightMode.value;
    Get.changeThemeMode(isLightMode.value ? ThemeMode.dark : ThemeMode.light);
    DBHelper.saveSettings('theme', isLightMode.value);
  }

  // Method to toggle the reminder setting
  void toggleReminderAt() {
    reminderAt.value = !reminderAt.value;
    DBHelper.saveSettings('reminder_at', reminderAt.value);
  }

  // Method to toggle the addPercentage setting
  void toggleAddPercentage() {
    addPercentage.value = !addPercentage.value;
    DBHelper.saveSettings('add_percentage', addPercentage.value);
  }

  // Method to retrieve saved settings from the database
  void getSavedSettings() async {
    Map<String, bool> savedSettings = await DBHelper.getSettings();
    isLightMode.value = savedSettings['theme'] ?? false;
    reminderAt.value = savedSettings['reminder_at'] ?? false;
    addPercentage.value = savedSettings['add_percentage'] ?? false;
    Get.changeThemeMode(savedSettings['theme'] ?? false ? ThemeMode.dark : ThemeMode.light);
  }
}
