import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/routes_name.dart';
import '../widget/widget.dart';
// In this we use sharedPreferences to save the user as data locally so user don't need to sign in again and again
class UserPreferences {
  String? email;
  String? pass;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Function of logout the user from the devices
  void logOutsetData(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: Loading());
      },
    );
    final SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setString("Email", "");
    userData.setString("Password", "");
    await auth.signOut();
    // ignore: use_build_context_synchronously
    context.go(RoutesName.loginScreen);
  }
  // to get the user data which is stores locally
  void getUserInfo() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    email = userData.getString("Email");
    pass = userData.getString("Password");
    debugPrint("Email: ${email!}");
  }
  // to store the user data locally
  Future saveLoginUserInfo(String userEmail, String userPassword) async {
    final SharedPreferences userCredentials = await SharedPreferences.getInstance();
    userCredentials.setString("Email", userEmail);
    userCredentials.setString("Password", userPassword);
  }
}