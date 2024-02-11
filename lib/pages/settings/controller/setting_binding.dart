import 'package:get/get.dart';
import 'package:to_do_list/controller/task_controller.dart';
import 'package:to_do_list/controller/task_controller.dart';
import 'package:to_do_list/pages/settings/controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(
      SettingsController(),
    ); Get.put<TaskController>(
      TaskController(),
    );


  }
}