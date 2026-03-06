import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: Theme.of(context).colorScheme.tertiaryFixed,
        ),
      ),
    );
  }
}
