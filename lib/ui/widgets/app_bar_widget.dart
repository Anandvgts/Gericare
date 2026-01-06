import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  const AppBarWidget({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = true,
    this.onBack,
    this.bottom,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppBar(
      backgroundColor: bottom != null ? Colors.white : Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      // leadingWidth: showBack ? 40 : 0,
      leading: showBack
          ? IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onBack ?? () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: colors.tertiaryFixed,
              ),
            )
          : null,
      titleSpacing: 0,
      title: _buildTitle(context),
      //  title != null
      //     ? Text(
      //         title!,
      //         style: AppTextStyle.title1Regular,
      //       )
      //     : null,
      bottom: bottom,
    );
  }

  Widget _buildTitle(BuildContext context) {
    // 🔥 Single title
    if (subtitle == null) {
      return Text(
        title!,
        style: AppTextStyle.title1Regular
            .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      );
    }

    // 🔥 Title + subtitle (Case Sheet, Consultation, etc.)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title!,
          style: AppTextStyle.title1Bold
              .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle!,
          style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


