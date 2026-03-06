import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientHeader extends StatelessWidget {
  final String name;
  final String gender;
  final int age;

  const PatientHeader({
    super.key,
    required this.name,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// PATIENT NAME
        Text(
          name,
          style: AppTextStyle.bodyText1.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 4.h),

        /// GENDER • AGE
        Text(
          "$gender  •  $age Yrs",
          style: AppTextStyle.bodyText2SubText.copyWith(
            fontSize: 14.sp,
            color: colors.onSecondaryFixed,
          ),
        ),
      ],
    );
  }
}
