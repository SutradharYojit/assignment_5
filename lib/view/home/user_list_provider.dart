import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../resources/string_manager.dart';
import '../../services/services.dart';

final userList = StateNotifierProvider<UserListData, List<UserDataModel>>((ref) => UserListData());

class UserListData extends StateNotifier<List<UserDataModel>> {
  UserListData() : super([]);
  bool loading = true;
  final db = FirebaseFirestore.instance;

  Future<void> getUserData() async {
    state.clear();
    // Get the list of users from the firebase database
    QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection(FBServiceManager.dbUser).get();
    state.addAll(snapshot.docs.map((docSnapshot) => UserDataModel.fromFirestore(docSnapshot)).toList());
    loading = false;
    final current = state
        .where((element) => element.uid == UserGlobalVariables.uid)
        .toList(); // the current user data from the list
    state.remove(current.first); // remove the current user from the blogger list
    state.insert(0, current.first); // insert the current user in the first of the list
    log(current.length.toString());
    log(state.length.toString());
    state = [...state];
  }
}
