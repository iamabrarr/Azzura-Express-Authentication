import 'package:azzurra_express/constants/icons.dart';
import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/utils/root.dart';
import 'package:azzurra_express/views/pages/auth%20flow/select%20login/select_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(
        const Duration(seconds: 3),
        () => Get.off(() => const Root(),
            transition: Transition.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(appIcon),
    ));
  }
}
