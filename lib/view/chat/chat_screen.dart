import 'dart:developer';
import 'package:assignment_5/model/model.dart';
import 'package:assignment_5/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.userInfo,
  });

  final UserDataModel userInfo;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _chatTextCtrl = TextEditingController();
  final List<ChatDataModel> chatData = [];
  final DateTime timeStamp = DateTime.now();
  final db = FirebaseFirestore.instance;
  final ScrollController _chatCtrl = ScrollController();
  final FocusNode myFocusNode = FocusNode();
  late final myFuture = chatStream();

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<Offset> position = Tween<Offset>(
    begin: const Offset(10, 0),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.linear),
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream() {
    List<String> ids = [UserGlobalVariables.uid!, widget.userInfo.uid!];
    ids.sort();
    String chatRoomId = ids.join("_");
    return db
        .collection(FBServiceManager.dbMessageHub)
        .doc(chatRoomId)
        .collection(FBServiceManager.dbMessageColl)
        .orderBy(FBServiceManager.fbTimeStamp, descending: true)
        .snapshots();
  }

  String getDate(int time) {
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(time);
    log(date1.toString());
    return DateFormat.jm().format(date1);
  }

  @override
  void dispose() {
    _chatTextCtrl.dispose();
    _chatCtrl.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _chatCtrl.addListener(() {
      log(_chatCtrl.offset.toString());
      if (_chatCtrl.offset > 155) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    log("build");
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userInfo.userName!,
            style: TextStyle(
              fontSize: screenWidth < 600 ? 18.sp: 7.sp,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.r),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Image.asset(ImageAssets.backgroundImg),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: myFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active ||
                              snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                              final data = snapshot.data!.docs;
                              chatData.clear();
                              chatData
                                  .addAll(data.map((docSnapshot) => ChatDataModel.fromFirestore(docSnapshot)).toList());
                              return Expanded(
                                child: ListView.builder(
                                  controller: _chatCtrl,
                                  reverse: true,
                                  padding: const EdgeInsets.all(
                                    15,
                                  ),
                                  itemCount: chatData.length,
                                  itemBuilder: (context, index) {
                                    return chatData[index].senderId == UserGlobalVariables.uid!
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  ChatBox(
                                                    color: Colors.teal,
                                                    bottomLeft: 20,
                                                    bottomRight: 0,
                                                    message: chatData[index].message!,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 4.r,
                                                      right: 10.r,
                                                    ),
                                                    child: Text(
                                                      getDate(chatData[index].timeStamp!).toString(),
                                                      style: TextStyle(
                                                        fontSize: screenWidth < 600 ? 15.sp: 7.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ChatBox(
                                                    color: ColorManager.receiverColor,
                                                    bottomLeft: 0,
                                                    bottomRight: 20,
                                                    message: chatData[index].message!,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 4.r,
                                                      right: 10.r,
                                                    ),
                                                    child: Text(
                                                      getDate(chatData[index].timeStamp!).toString(),
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                  },
                                ),
                              );
                            } else {
                              return const Text('Empty data');
                            }
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Expanded(
                              child: Center(
                                child: SpinKitDualRing(
                                  color: Colors.black,
                                  size: 45,
                                ),
                              ),
                            );
                          } else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
                        child: Row(
                          children: [
                            Expanded(
                              child: PrimaryTextFilled(
                                focusNode: myFocusNode,
                                controller: _chatTextCtrl,
                                hintText: "Enter message",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.r),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  FireBaseServices.sendMessage(
                                    receiverId: widget.userInfo.uid!,
                                    senderId: UserGlobalVariables.uid!,
                                    message: _chatTextCtrl.text.trim(),
                                    timeStamp: timeStamp.millisecondsSinceEpoch,
                                  );
                                  _chatTextCtrl.clear();
                                },
                                child: const CircleAvatar(
                                  maxRadius: 28,
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.send, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 75.h,
                    right: 0.h,
                    child: UpAnimation(position: position, scrollController: _chatCtrl),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
