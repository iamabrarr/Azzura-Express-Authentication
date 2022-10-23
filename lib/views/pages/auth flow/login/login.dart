import 'package:azzurra_express/constants/colors.dart';
import 'package:azzurra_express/constants/images.dart';
import 'package:azzurra_express/controllers/auth_controller.dart';
import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:azzurra_express/views/pages/auth%20flow/forget%20password/forget_password.dart';
import 'package:azzurra_express/views/widgets/custom_button.dart';
import 'package:azzurra_express/views/widgets/custom_textfield.dart';
import 'package:azzurra_express/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../signup/signup.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(ButtonsController());
    Get.put(AuthController());
    return Obx(
     ()=> ShowLoading(
        inAsyncCall: Get.find<ButtonsController>().isLoading.value,
        child: Scaffold(
          backgroundColor: kauthScaffoldColor,
          body: AnimationLimiter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Image.asset(
                        loginImage,
                        height: SizeConfig.heightMultiplier * 30,
                      ),
                      Text(
                        "Hello Again!",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.8,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 0.5,
                      ),
                      Text(
                        "Welcome back you've been missed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                      CustomTextField(
                          controller: emailCont,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      CustomTextField(
                          controller: passCont,
                          hintText: "Password",
                          keyboardType: TextInputType.emailAddress),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPasswordPage(),
                                transition: Transition.leftToRight);
                          },
                          child: Text(
                            "Recovery Password?",
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.6,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                      CustomButton(
                          text: "Sign in",
                          isBorder: false,
                          onTap: () {
                            Get.find<ButtonsController>().isLoading.value = true;
                            Get.find<AuthController>()
                                .onSignIn(emailCont.text, passCont.text);
                            // Get.to(()=>const BottomNavBar(),transition: Transition.leftToRight);
                          }),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                color: Colors.grey.shade700),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => SignupPage(),
                                    transition: Transition.downToUp);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    color: kPrimaryColor,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
