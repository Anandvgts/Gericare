import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';

class AuthLabel extends StatelessWidget {
  final String text;
  

  const AuthLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(text, style: AppTextStyle.labelTextStyle),
    );
  }
}
