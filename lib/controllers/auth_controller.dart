import 'dart:math';
import 'package:azzurra_express/constants/colors.dart';
import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/models/user_model.dart';
import 'package:azzurra_express/services/database.dart';
import 'package:azzurra_express/utils/root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class AuthController extends GetxController {
  //TWILIO REQUIRED DETAILS
  final twilioAccountSID =
      ""; // replace *** with Account SID
  final twilioAuthToken =
      ""; // replace xxx with Auth Token
  final twilioNumber = ""; // replace .... with Twilio Number
  //FIREBASE METHODS
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString verificationCode = "".obs;
  //Here we take FirebaseUser as observable
  final Rxn<User> _firebaseUser = Rxn<User>();

  //Here we use getter for making the user data email to call anywhere in the app
  String? get user => _firebaseUser.value?.email;

  //Here we take User Model as observable for showing the user data in the app
  Rx<UserModel> userModel = UserModel().obs;

  //Here we get and set the usermodel data for using anywhere in the app
  UserModel get userInfo => userModel.value;
  set userInfo(UserModel value) => userModel.value = value;

  //Here we are getting the userData
  User? get userss => _firebaseUser.value;

  @override
  // ignore: type_annotate_public_apis
  onInit() {
    //Here we bind the stream which is used getting the data in the stream which have more then one type of data it is only used on observable list only
    _firebaseUser.bindStream(_auth.authStateChanges());

    super.onInit();
  }

  getUser() async {
    try {
      print("printing");
      //It is getting data from the collection of "Users" which is in the database(uid is the unique id of each user in the app)
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userss!.uid)
          .get();
      userInfo = UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //OTP verification
  verifyPhone(String phoneNumber) async {
    try {
      final twilioFlutter = TwilioFlutter(
          accountSid: twilioAccountSID,
          authToken: twilioAuthToken,
          twilioNumber: twilioNumber);
      Random rand = Random();
      var code = rand.nextInt(9000) + 1000;
      print("This is the thing $code");
      verificationCode.value = code.toString();
      twilioFlutter.sendSMS(
          toNumber: "+$phoneNumber",
          messageBody: "Azzurra Express: This is your verification code $code");
    } catch (e) {
      Get.snackbar("Please try again", "Enter a valid OTP",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  checkCode(
      String smsCode,
      String firstName,
      String lastName,
      String email,
      String phone,
      String country,
      String state,
      String city,
      String password,
      String address) async {
    try {
      if (verificationCode.value == smsCode) {
        print("This is the code $smsCode");
        onVerifiedPhone(firstName, lastName, email, phone, country, state, city,
                password, address)
            .then(
                (val) => Get.find<ButtonsController>().isLoading.value = false)
            .then((val) => Get.offAll(() => const Root(),
                transition: Transition.leftToRight));

        print("User logged in successfully ");
      } else {
        Get.find<ButtonsController>().isLoading.value = false;
        Get.snackbar("Please try again", "Enter a valid OTP",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.find<ButtonsController>().isLoading.value = false;
      Get.snackbar("Please try again", "Enter a valid OTP",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  onVerifiedPhone(
      String firstName,
      String lastName,
      String email,
      String phone,
      String country,
      String state,
      String city,
      String password,
      String address) async {
    final UserCredential _authResult = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);

    //creating user in the database
    //UserModel is the model where the data of the user goes and then we show the user data from the model class by the user controller in the app
    final UserModel _user = UserModel(
        id: _authResult.user?.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phone,
        country: country,
        homeAddress: address,
        state: state,
        city: city,
        password: password);

    // if a user is successfully created then it goes to the homepage
    if (await DataBase().createUser(_user)) {
      Get.put(AuthController(), permanent: true);
    }
  }

  onSignOut() async {
    try {
      await _auth
          .signOut()
          .then((value) => Get.deleteAll())
          .then((value) => Get.offAll(() => const Root()));
    } catch (e) {
      Get.snackbar("Error", "$e".split("]")[1]);
    }
  }

  onSignIn(String email, String password) async {
    try {
      //if the sign in done successfully then it will go to the homepage otherwise it shows error
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            Get.put(AuthController());
            getUser();
          })
          .then(
              (value) => Get.find<ButtonsController>().isLoading.value = false)
          .then((value) => Get.offAll(const Root()));
    } catch (e) {
      Get.find<ButtonsController>().isLoading.value = false;
      Get.snackbar("Please try again", "$e".split("]")[1],
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  onForgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) =>
          Get.snackbar("Reset Email Send Successfully",
              "Please check your email for reset password",
              backgroundColor: kPrimaryColor, colorText: Colors.white));
    } catch (e) {
      Get.snackbar("Please try again", "$e".split("]")[1],
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
