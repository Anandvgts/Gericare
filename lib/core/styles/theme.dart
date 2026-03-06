import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
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
        onSecondaryFixed: AppColor.secondaryText,
        surfaceContainerHigh: AppColor.success,
        surfaceVariant: AppColor.segmentcolor,

        //reports chip
        onTertiary: AppColor.newShip,
        onTertiaryContainer: AppColor.newShipbg,
        onTertiaryFixed: AppColor.recivedShip,
        onTertiaryFixedVariant: AppColor.recivedShipBg,
        surfaceTint: AppColor.dateDiveder,

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

  static InputDecoration otpDecoration(BuildContext context) {
    return InputDecoration(
      counterText: "",
      filled: true,
      fillColor: context.colors.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: context.colors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: context.colors.primary,
          width: 1.5,
        ),
      ),
    );
  }

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
