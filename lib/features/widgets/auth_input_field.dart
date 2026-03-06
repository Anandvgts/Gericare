import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';

// class AuthInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final IconData? icon;
//   final bool obscure;
//   final String? error;

//   const AuthInputField({
//     super.key,
//     required this.controller,
//     this.icon,
//     this.obscure = false,
//     this.error,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscure,
//       decoration: InputDecoration(
//         prefixIcon: icon != null ? Icon(icon) : null,
//         hintText: 'Enter',
//         errorText: error,
//         hintStyle: AppTextStyle.bodyText1.copyWith(
//           color: Theme.of(context).colorScheme.onSecondaryFixed,
//           fontSize: 14.h,
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14.r),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController controller;

  /// Prefix icon (left)
  final IconData? prefixIcon;

  /// Suffix icon (right)
  final IconData? suffixIcon;

  /// Tap on suffix icon (eye toggle etc.)
  final VoidCallback? onSuffixTap;

  /// Text obscure (password)
  final bool obscureText;

  /// Error message
  final String? error;

  /// Optional extras (won’t affect old screens)
  final TextInputType keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final bool enabled;

  const AuthInputField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.error,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textAlign: textAlign,
      enabled: enabled,
      decoration: InputDecoration(
        counterText: "",

        /// LEFT ICON
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,

        /// RIGHT ICON
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixTap,
              )
            : null,

        hintText: 'Enter',
        errorText: error,
        hintStyle: AppTextStyle.bodyText1.copyWith(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          fontSize: 14.h,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
    );
  }
}
