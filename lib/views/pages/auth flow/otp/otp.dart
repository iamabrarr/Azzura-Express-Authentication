import 'package:azzurra_express/constants/colors.dart';
import 'package:azzurra_express/constants/images.dart';
import 'package:azzurra_express/controllers/auth_controller.dart';
import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:azzurra_express/views/widgets/custom_button.dart';
import 'package:azzurra_express/views/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'components/otp_textfield.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {Key? key,
      required this.email,
      required this.pass,
      required this.firstName,
      required this.lastName,
      required this.country,
      required this.city,
      required this.state,
      required this.telephone,
      required this.address})
      : super(key: key);
  final String email,
      pass,
      firstName,
      lastName,
      country,
      city,
      state,
      telephone,
      address;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final authCont = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    authCont.verifyPhone(widget.telephone);
  }

  TextEditingController firstDigit = TextEditingController();
  TextEditingController secondDigit = TextEditingController();
  TextEditingController thirdDigit = TextEditingController();
  TextEditingController forthDigit = TextEditingController();
  final cont = Get.find<ButtonsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> ShowLoading(
        inAsyncCall: cont.isLoading.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: AnimationLimiter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 2,
                    horizontal: SizeConfig.widthMultiplier * 5),
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
                        width: SizeConfig.widthMultiplier * 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              otpImage,
                              height: SizeConfig.heightMultiplier * 30,
                            ),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: BackButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                ))
                          ],
                        ),
                      ),
                      Text(
                        "Verification",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 3,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Text(
                        "A 4-digit code has been sent to",
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "+${widget.telephone}",
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OtpField(
                              first: true,
                              last: false,
                              controller: firstDigit,
                            ),
                            OtpField(
                              first: false,
                              last: false,
                              controller: secondDigit,
                            ),
                            OtpField(
                              first: false,
                              last: false,
                              controller: thirdDigit,
                            ),
                            OtpField(
                              first: false,
                              last: true,
                              controller: forthDigit,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      CustomButton(
                          text: "Submit",
                          isBorder: false,
                          onTap: () {
                            cont.isLoading.value = true;
                            authCont
                                .checkCode(
                                    "${firstDigit.text}${secondDigit.text}${thirdDigit.text}${forthDigit.text}",
                                    widget.firstName,
                                    widget.lastName,
                                    widget.email,
                                    "+${widget.telephone}",
                                    widget.country,
                                    widget.state,
                                    widget.city,
                                    widget.pass,
                                    widget.address);
                          }),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      const Text(
                        "Didn't you receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          authCont.verifyPhone(widget.telephone);
                        },
                        child: const Text(
                          "Resend New Code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
