import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    super.key,
    required this.message,
    required this.color,
    required this.bottomRight,
    required this.bottomLeft,
  });

  final double bottomLeft;
  final double bottomRight;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      constraints: BoxConstraints(
        maxWidth: 175.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        ),
      ),
      child: Text(message),
    );
  }
}
