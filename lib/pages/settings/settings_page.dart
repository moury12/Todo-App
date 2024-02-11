
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_ui/mh_ui.dart';
import 'package:to_do_list/pages/settings/controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
                () {
          return Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SettingWidget(
                title: 'Theme',
                value: SettingsController.to.isLightMode.value,
                onChanged: (value) {
                  SettingsController.to.toggleTheme();
                },
              ),  SettingWidget(
                title: 'Reminder',
                value: SettingsController.to.reminderAt.value,
                onChanged: (value) {
                  SettingsController.to.toggleReminderAt();
                },
              ), SettingWidget(
                title: 'Show Percentage',
                value: SettingsController.to.addPercentage.value,
                onChanged: (value) {
                  SettingsController.to.toggleAddPercentage();
                },
              ),
            ],
          );
        }
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool value) onChanged;
  const SettingWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        space3R,
        Switch(
          value: value,
          onChanged: onChanged,
        )
      ],
    );
  }
}
