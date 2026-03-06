import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final Widget? bottom;
  final bool showBack;
  final bool isCalnder;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.subTitle,
    this.bottom,
    this.showBack = true,
    this.isCalnder = false,
    this.actions,
  });

  // @override
  // Size get preferredSize => Size.fromHeight(56.h);
  @override
  Size get preferredSize => Size.fromHeight(bottom != null
      ? isCalnder
          ? 200
          : 120
      : 64);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colors.onPrimary,
      elevation: 0,
      centerTitle: false, // 👈 matches Figma
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: colors.onSurface,
              onPressed: () => Navigator.pop(context),
            )
          : null,
      titleSpacing: showBack ? 0 : 16.w,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyText1.copyWith(
              fontSize: subTitle == null ? 16.sp : 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subTitle != null)
            Text(
              subTitle!,
              style: AppTextStyle.bodyText1.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: context.colors.onSecondaryFixed),
            )
        ],
      ),

      actions: actions,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                color: colors.onPrimary,
                child: bottom,
              ),
            )
          : null,
    );
  }
}
