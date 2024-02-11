import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/database/db_helper.dart';
import 'package:to_do_list/pages/settings/controller/setting_binding.dart';
import 'package:to_do_list/pages/splash_page.dart';
import 'package:to_do_list/routes/app_routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DBHelper.initDB();
  } catch (e) {
  throw(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'To Do app',
      getPages: AppRoutes.routes(),
      initialRoute: SplashScreen.routeName,
      initialBinding: SettingsBinding(),
    );
  }
}
