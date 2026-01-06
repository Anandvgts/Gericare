import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppStyle {
  static const String fontFamily = "DMSans";

  static final ThemeData appTheme = ThemeData(
    useMaterial3: false,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColor.white,
    colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        background: AppColor.background,
        surface: AppColor.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: AppColor.labletext,
        onBackground: AppColor.textOnBackground,
        onSurface: AppColor.textOnPrimary,
        outline: AppColor.outline,
        outlineVariant: AppColor.containerOutline,
        primaryFixed: AppColor.black,
        secondaryFixed: AppColor.grey,
       

        //icon
        tertiary: AppColor.tertiary,
        tertiaryFixed: AppColor.textOnTertiary),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.background,
    ),
  );

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.08), spreadRadius: 0, blurRadius: 4),
  ];

  static const Widget customDivider = SizedBox(
    height: 0.6,
    child: Divider(
      color: AppColor.outline,
      thickness: 1.2,
    ),
  );

  static Decoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );

  static RoundedRectangleBorder roundedRectangleBorder =
      const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
  );

  static Decoration filterCardDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: AppColor.filterBorderColor),
    borderRadius: BorderRadius.circular(5),
  );

  static Decoration cardDecorationBorder = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Color(0xFFECECEC)),
    borderRadius: BorderRadius.circular(5),
  );

  static descriptionDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        counterText: "",
        hintStyle:
            AppTextStyle.bodyText2.copyWith(color: const Color(0xffACB4BE)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColor.paymentModeBorder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColor.paymentModeBorder)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColor.paymentModeBorder)));
  }

  static InputDecoration formFieldDecoration(
    BuildContext context,
    String hintText,
  ) {
    final colors = Theme.of(context).colorScheme;

    return InputDecoration(
      hintText: hintText,
      counterText: "",
      isDense: true,

      /// Controls HEIGHT of the field
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14, // 🔥 THIS controls height
      ),

      hintStyle: AppTextStyle.bodyText2SubText,

      /// DEFAULT BORDER
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colors.outline,
          width: 1.2,
        ),
      ),

      /// FOCUSED BORDER
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colors.primary,
          width: 1.6,
        ),
      ),

      /// ERROR BORDER
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colors.error,
          width: 1.4,
        ),
      ),

      /// FOCUSED ERROR BORDER
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colors.error,
          width: 1.6,
        ),
      ),
    );
  }

  static eodTextDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        counterText: "",
        errorText: "",
        hintStyle:
            AppTextStyle.bodyText2.copyWith(color: const Color(0xffACB4BE)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              const BorderSide(color: AppColor.editTextFieldBorder, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColor.paymentModeBorder)));
  }

  static BoxDecoration elevatedButton =
      BoxDecoration(color: AppColor.secondary);

  static InputDecoration searchDecoration = InputDecoration(
    fillColor: AppColor.editTextField,
    filled: true,
    labelText: 'Search',
    contentPadding: EdgeInsets.all(5),
    prefixIcon: const Icon(
      Icons.search,
      color: Colors.black,
    ),
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.searchBorderColor, width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.searchBorderColor, width: 1.0),
    ),
  );


  

  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(
        color: AppColor.secondary.withOpacity(0.2),
        spreadRadius: 0.5,
        blurRadius: 1),
  ];

  static List<Shadow> textShadow = <Shadow>[
    const Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Colors.black12,
    ),
    const Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.black12,
    ),
  ];
}

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
      color: AppColor.background,
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

  static TextStyle labelTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColor.textLabelColor,
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
  static TextStyle heading24 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
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
