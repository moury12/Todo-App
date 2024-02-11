import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constant/assets_constant.dart';
import 'package:to_do_list/pages/dashboard_page.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName ='/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),() {
      Get.offAndToNamed(DashboardScreen.routeName);
    },);
    return Scaffold(
      body:  Center(
        child: 
        Image.asset(AssetsConstant.logoIcon,height: 250,),
      ),
    );
  }
}
