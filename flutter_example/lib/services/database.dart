import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username) {

  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("user")
        .add(userMap);
  }
}