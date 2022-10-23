import 'package:azzurra_express/controllers/auth_controller.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCont = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: Obx(
          ()=> Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Name : ${authCont.userInfo.firstName} ${authCont.userInfo.lastName}"),
              Text("Email : ${authCont.userInfo.email}"),
              Text("Phone : ${authCont.userInfo.phoneNumber}"),
              Text("Address : ${authCont.userInfo.homeAddress}"),
              Text("Country : ${authCont.userInfo.country}"),
              Text("State : ${authCont.userInfo.state}"),
              Text("City : ${authCont.userInfo.city}"),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              ElevatedButton(
                  onPressed: () => authCont.onSignOut(),
                  child: const Text("Log out"))
            ],
          ),
        ),
      ),
    );
  }
}
