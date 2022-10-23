import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/views/pages/auth%20flow/select%20login/select_login.dart';
import 'package:azzurra_express/views/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(ButtonsController());
    return GetX<AuthController>(initState: (_) async {
      Get.put<AuthController>(AuthController());
    }, builder: (_) {
      if (Get.find<AuthController>().user != null) {
        _.getUser();
        return const HomePage();
      } else {
        return SelectLoginPage();
      }
    });
  }
}
