import 'package:azzurra_express/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///for creating user data

  Future<bool> createUser(UserModel user) async {
    try {
      await _firestore.collection("Users").doc(user.id).set({
        "FirstName": user.firstName,
        "LastName": user.lastName,
        "Email": user.email,
        "PhoneNumber": user.phoneNumber,
        "HomeAddress": user.homeAddress,
        "Country": user.country,
        "City": user.city,
        "State": user.state,
        "Password": user.password,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
