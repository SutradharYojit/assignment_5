// This Firebase user data model, To get the list of the user data

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String? userName;
  final String? email;
  final String? uid;

  UserDataModel({
    this.userName,
    this.email,
    this.uid,
  });

  factory UserDataModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return UserDataModel(
      userName: data?['user_name'],
      email: data?['email'],
      uid: data?['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['uid'] = this.uid;
    return data;
  }
}
