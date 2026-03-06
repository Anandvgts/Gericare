
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';

class BottomCtaButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const BottomCtaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
            elevation: 0,
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: AppTextStyle.button,
                ),
        ),
      ),
    );
  }
}
