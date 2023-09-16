import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/resources.dart';

class TextRich extends StatelessWidget {
  const TextRich({
    super.key,
    required this.firstText,
    required this.secText,
    this.screenWidth,
  });

  final String firstText;
  final String secText;
  final double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: ColorManager.blackColor,
          fontSize: screenWidth! < 600 ? 14.sp : 5.sp,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '\t $secText',
            style: TextStyle(
              color: ColorManager.blueColor,
              fontSize: screenWidth! < 600 ? 14.sp : 5.sp,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }
}
