
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, firstName,lastName,email,phoneNumber,homeAddress,country,city,state,password;
  UserModel({
    this.password,
    this.city,
    this.country,
    this.firstName,
    this.lastName,
    this.homeAddress,
    this.id,
    this.phoneNumber,
    this.email,
    this.state,
  });
  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    firstName=doc["FirstName"];
    lastName=doc["LastName"];
    email=doc["Email"];
    phoneNumber=doc["PhoneNumber"];
    homeAddress=doc["HomeAddress"];
    country=doc["Country"];
    city=doc["City"];
    state=doc["State"];
    password = doc["Password"];
    
  }
}
