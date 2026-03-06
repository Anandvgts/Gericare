import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateDivider extends StatelessWidget {
  final String label;

  const DateDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1.0, color: colors.surfaceTint)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              // color: colors.surface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Text(
              label,
              style: AppTextStyle.bodyText2SubText.copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(child: Divider(thickness: 1.0, color: colors.surfaceTint)),
        ],
      ),
    );
  }
}
