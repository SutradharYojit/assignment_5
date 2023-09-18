import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataModel {
  final String? message;
  final String? receiverId;
  final String? senderId;
  final int? timeStamp;

  ChatDataModel({
    this.message,
    this.receiverId,
    this.senderId,
    this.timeStamp
  });

  factory ChatDataModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return ChatDataModel(
      message: data?['message'],
      receiverId: data?['receiver_id'],
      senderId: data?['sender_id'],
      timeStamp: data?['timeStamp'],
    );
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['user_name'] = this.userName;
//   data['email'] = this.email;
//   data['uid'] = this.uid;
//   return data;
// }
}
