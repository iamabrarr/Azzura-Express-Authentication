// ignore_for_file: deprecated_member_use

import 'package:azzurra_express/constants/images.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:azzurra_express/views/pages/auth%20flow/login/login.dart';
import 'package:azzurra_express/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class SelectLoginPage extends StatelessWidget {
  SelectLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimationLimiter(
          child: Center(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 100.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 8,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 40,
                    width: SizeConfig.widthMultiplier * 80,
                    child: Image.asset(
                      selectLoginImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Your Title here",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 90,
                    child: Text(
                      "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.6,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 12,
                  ),
                  CustomButton(text: "Registor", isBorder: true, onTap: () {}),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  CustomButton(
                      text: "Login",
                      isBorder: false,
                      onTap: () {
                        Get.to(() => LoginPage(),
                            transition: Transition.leftToRight);
                      })
                ],
              ),
            ),
          ),
        ),
     
    );
  }
}
