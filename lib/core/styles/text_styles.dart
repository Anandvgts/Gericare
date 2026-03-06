import 'package:doctor/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headline1 = const TextStyle(
      fontSize: 102,
      fontWeight: FontWeight.w300,
      color: AppColor.textOnPrimary,
      letterSpacing: -1.5);

  static TextStyle headline2 = const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w300,
      color: AppColor.textOnPrimary,
      letterSpacing: -0.5);

  static TextStyle buttonLabel = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.whiteColor,
      letterSpacing: 0.4);

  static TextStyle headline3 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColor.textOnPrimary,
  );

  static TextStyle formHeadline = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColor.textOnPrimary,
  );

  static TextStyle headline4 = const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.25);

  static TextStyle H6 = const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0);
  static TextStyle headline5 = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: AppColor.textOnPrimary,
  );

  static TextStyle headline6 = const TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.15);

  static TextStyle subtitle1 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.15);

  static TextStyle subtitle2 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.1);

  static TextStyle heading48 = const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.1);

  static TextStyle bodyText1 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.5);

  static TextStyle fontLabelStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.5);

  static TextStyle bodyText1SubText = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.secondaryText,
      letterSpacing: 0.5);

  static TextStyle bodyText2 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.25);

  static TextStyle bodyText2SubText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.secondaryText,
      letterSpacing: 0.25);

  static TextStyle bodyText2Bold = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.25);

  static TextStyle button = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
      letterSpacing: 1.25);

  static TextStyle title1Bold = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.25);

  static TextStyle title1Regular = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.25);

  static TextStyle title2Bold = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColor.secondaryText,
      letterSpacing: 0.25);

  static TextStyle caption = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0x80000000),
      letterSpacing: 0.4);

  static TextStyle formHeadBlack = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 0.4);

  static TextStyle highlight = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppColor.editTextFieldBorder,
      letterSpacing: 0.1);
  static TextStyle welcomeStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.1);

  static TextStyle labelTextStyle = TextStyle(
      fontSize: 14.h,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.1);
  static TextStyle subtitle1white = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      letterSpacing: 0.1);
  static TextStyle subTextRegualr = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.secondaryText,
      letterSpacing: 0.1);

  static TextStyle nameStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: 0.1);
  static TextStyle homeBalance = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteColor,
  );
  static TextStyle headingList = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColor.headingPurple,
  );
  static TextStyle status = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Colors.red);
  static TextStyle heading24 = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24.h,
      // fontWeight: FontWeight.bold,
      color: AppColor.textOnBackground);

  static TextStyle smallText = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColor.textOnPrimary,
  );
}

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDark => theme.brightness == Brightness.dark;
}
