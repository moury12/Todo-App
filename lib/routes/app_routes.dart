import 'package:get/get.dart';
import 'package:to_do_list/pages/add_task_page.dart';
import 'package:to_do_list/pages/dashboard_page.dart';
import 'package:to_do_list/pages/edit_task_page.dart';
import 'package:to_do_list/pages/settings/controller/setting_binding.dart';
import 'package:to_do_list/pages/settings/settings_page.dart';
import 'package:to_do_list/pages/splash_page.dart';

class AppRoutes {
  static routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: DashboardScreen.routeName,
          /*  binding: SettingsBinding(),*/
          page: () => const DashboardScreen(),
        ),
        GetPage(
          name: SettingsScreen.routeName,
          page: () => const SettingsScreen(),
        ),
        GetPage(
          name: ViewTaskScreen.routeName,
          page: () => const ViewTaskScreen(),
        ),
        GetPage(
          name: EditTaskScreen.routeName,
          page: () => const EditTaskScreen(),
        ),
      ];
}
