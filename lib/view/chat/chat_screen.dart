import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatScreen = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  final int a = 1;

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat Screen"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.r),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return index.isEven
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const ChatBox(
                                      color: Colors.teal,
                                      bottomLeft: 20,
                                      bottomRight: 0,
                                      message:
                                          "asdads flsdh shgjls sdhgjl hjlsdhgks gjklshg sjkgh sdghjl ahgjldhlh djlsgh jsdas",
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 4.r,
                                        right: 10.r,
                                      ),
                                      child: Text(
                                        "09:10 AM",
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
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChatBox(
                                      color: Colors.teal.shade200,
                                      bottomLeft: 0,
                                      bottomRight: 20,
                                      message:
                                          "asdads flsdh shgjls sdhgjl hjlsdhgks gjklshg sjkgh sdghjl ahgjldhlh djlsgh jsdas",
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 4.r,
                                        right: 10.r,
                                      ),
                                      child: Text(
                                        "09:10 AM",
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
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.r,top: 5.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryTextFilled(
                          focusNode: myFocusNode,
                          controller: _chatScreen,
                          hintText: "Enter message",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.r),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            myFocusNode.unfocus();
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
          ),
        ),
      ),
    );
  }
}
