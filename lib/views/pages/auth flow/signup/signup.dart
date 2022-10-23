import 'package:azzurra_express/constants/colors.dart';
import 'package:azzurra_express/constants/images.dart';
import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:azzurra_express/views/pages/auth%20flow/otp/otp.dart';
import 'package:azzurra_express/views/widgets/custom_button.dart';
import 'package:azzurra_express/views/widgets/custom_textfield.dart';
import 'package:azzurra_express/views/widgets/show_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'components/csc_picker.dart';
import 'components/phone_number_inputfield.dart';

class SignupPage extends StatelessWidget {
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController telePhone = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cont = Get.find<ButtonsController>();
    return Obx(
      () => ShowLoading(
        inAsyncCall: cont.isLoading.value,
        child: Scaffold(
          backgroundColor: kauthScaffoldColor,
          body: AnimationLimiter(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
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
                          height: SizeConfig.heightMultiplier * 7,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: BackButton(
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        Text(
                          "Create account!",
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.3,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        CustomTextField(
                            controller: firstNameCont,
                            hintText: "First Name",
                            keyboardType: TextInputType.text),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        CustomTextField(
                            controller: lastNameCont,
                            hintText: "Last Name",
                            keyboardType: TextInputType.text),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        CustomTextField(
                            controller: emailCont,
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        PhoneNumberInputField(controller: telePhone),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        CustomTextField(
                            controller: address,
                            hintText: "Home Address",
                            keyboardType: TextInputType.text),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        const CountryCityPicker(),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        CustomTextField(
                            controller: passCont,
                            hintText: "Password",
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        CustomButton(
                            text: "Sign up",
                            isBorder: false,
                            onTap: () async {
                              if (firstNameCont.text.isNotEmpty &&
                                  lastNameCont.text.isNotEmpty &&
                                  emailCont.text.isNotEmpty &&
                                  telePhone.text.isNotEmpty &&
                                  address.text.isNotEmpty &&
                                  cont.countryCode.value != "" &&
                                  cont.city.value != "" &&
                                  cont.state.value != "" &&
                                  cont.country.value != "") {
                                if (emailCont.text.isEmail) {
                                  if (passCont.text.length >= 8) {
                                    cont.isLoading.value = true;
                                    await FirebaseFirestore.instance
                                        .collection("Users")
                                        .where("Email",
                                            isEqualTo: emailCont.text)
                                        .get()
                                        .then((value) {
                                      if (value.docs.isEmpty) {
                                        FirebaseFirestore.instance
                                            .collection("Users")
                                            .where("PhoneNumber",
                                                isEqualTo:
                                                    "+${cont.countryCode.value}${telePhone.text}")
                                            .get()
                                            .then((value) {
                                          if (value.docs.isEmpty) {
                                            cont.isLoading.value = false;
                                            ///QUERY FOR GOING TO OTP
                                            Get.to(
                                                  () => OtpPage(
                                                      email: emailCont.text,
                                                      pass: passCont.text,
                                                      firstName:
                                                          firstNameCont.text,
                                                      lastName:
                                                          lastNameCont.text,
                                                      country:
                                                          cont.country.value,
                                                      city: cont.city.value,
                                                      state: cont.state.value,
                                                      telephone:
                                                          "${cont.countryCode.value}${telePhone.text}",
                                                      address: address.text),
                                                  transition:
                                                      Transition.rightToLeft);


                                          } else {
                                            cont.isLoading.value = false;
                                            Get.snackbar("Please try again",
                                                "Phone number already exists",
                                                backgroundColor:
                                                    Colors.redAccent,
                                                colorText: Colors.white);
                                          }
                                        });
                                      } else {
                                        cont.isLoading.value = false;
                                        Get.snackbar("Please try again",
                                            "Email address already exists",
                                            backgroundColor: Colors.redAccent,
                                            colorText: Colors.white);
                                      }
                                    });
                                  } else {
                                    Get.snackbar("Please try again",
                                        "Your Password Length is too short",
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white);
                                  }
                                } else {
                                  Get.snackbar("Please try again",
                                      "The email address is badly formatted",
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white);
                                }
                              } else {
                                Get.snackbar("Please try again",
                                    "Please fill all the information",
                                    backgroundColor: Colors.redAccent,
                                    colorText: Colors.white);
                              }
                            }),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
                                  color: Colors.grey.shade700),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Sign In",
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
      ),
    );
  }
}
