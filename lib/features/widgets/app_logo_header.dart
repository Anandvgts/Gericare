import 'package:doctor/core/constants/images.dart';
import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class AppLogoHeader extends StatelessWidget {
  final bool showTagline;
  final EdgeInsetsGeometry? margin;

  const AppLogoHeader({
    super.key,
    this.showTagline = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.only(top: 24.h),
      child: Column(
        children: [
          /// Logo
          Image.asset(
            Images.appLogo, // app_logo.png
            width: 160.w,
            fit: BoxFit.contain,
          ),

          // if (showTagline) ...[
          //   SizedBox(height: 8.h),

          //   /// Tagline
          //   Text(
          //     'ELDERCARE BY GERIATRICIANS',
          //     style: AppTextStyle.labelTextStyle.copyWith(
          //       color: AppColor.secondaryText,
          //       letterSpacing: 1.2,
          //     ),
          //   ),
          // ],
        
        ],
      ),
    );
  }
}
