import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../resources/resources.dart';
import '../resources/string_manager.dart';
import '../routes/routes_name.dart';
import '../widget/widget.dart';
import 'services.dart';
// Class defines the All Firebase services Like Login, Signup and more.

class FireBaseServices {
  final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;
  final userPreferences = UserPreferences();
  static final bar = WarningBar();

  Future signUP(BuildContext context,
      {required String textEmail, required String textPass, required String userName}) async {
    debugPrint("Button pressed");
    // Show Loading screen while function is called
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: Loading(),
        );
      },
    );
    try {
      // set the user credentials to the firebase Authentication Services
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          // save the user data to the Firebase clod store Services
          await db.collection(FBServiceManager.dbUser).doc().set({
            FBServiceManager.fbUserName: userName,
            FBServiceManager.fbEmail: textEmail,
            FBServiceManager.fbUid: auth.currentUser?.uid,
          });
          // save the user credentials locally so user don't need to login in every time
          await userPreferences.saveLoginUserInfo(textEmail, textPass);
          // ignore: use_build_context_synchronously
          context.go(RoutesName.homeScreen); // move to dashboard screen
        },
      );
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      final notExist = bar.snack(e.message.toString(), ColorManager.redColor);
      debugPrint("Failed to sign up${e.message}");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(notExist);
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // remove the loding screen and give the warning to the user when exception is catch
    }
  }

// SignIn Function to logged in app
  Future signIN(BuildContext context, {required String textEmail, required String textPass}) async {
    debugPrint("Button pressed");
    final notExist = bar.snack("Account doesn't exist", ColorManager.redColor);
    // Show Loading screen while function is called

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: Loading());
        });
    try {
      // check if user is credentials are correct or not
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          log("Success full logged in");
          // save the user credentials locally so user don't need to login in every time
          await userPreferences.saveLoginUserInfo(textEmail, textPass).then(
            (value) {
              context.go(RoutesName.homeScreen);
            },
          );
          // ignore: use_build_context_synchronously
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(notExist);
    }
  }

  static Future sendMessage({
    required String receiverId,
    required String senderId,
    required String message,
    required int timeStamp,
  }) async {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    log("message Send");
    try {
      await db.collection(FBServiceManager.dbMessageHub).doc(chatRoomId).collection("messages").add({
        FBServiceManager.fbMessage: message,
        FBServiceManager.fbSenderId: senderId,
        FBServiceManager.fbReceiverId: receiverId,
        FBServiceManager.fbTimeStamp: timeStamp,
      }).then(
        (value) => log("Successfully message add"),
      );
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      // ignore: use_build_context_synchronously
    }
  }
}

class UserGlobalVariables {
  static String? docId;
  static String? uid;
  static String? username;

  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  static Future<void> getUserData() async {
    final data = await db
        .collection(FBServiceManager.dbUser)
        .where(FBServiceManager.fbUid, isEqualTo: auth.currentUser!.uid)
        .get();
    log("get Success");
    uid = auth.currentUser!.uid;
    docId = data.docs[0].id;
    username = data.docs[0][FBServiceManager.fbUserName];
    log(uid.toString());
  }
}
