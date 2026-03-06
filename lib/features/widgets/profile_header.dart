import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/theme.dart';
import 'package:doctor/features/auth/logout/logout_controller.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ProfileHeader extends ConsumerWidget {
  final String name;
  final String greeting;
  final VoidCallback onNotificationTap;
  final VoidCallback onScanTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.greeting,
    required this.onNotificationTap,
    required this.onScanTap,
  });

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(25, 120, 100, 0),
      items: [
        PopupMenuItem(
            value: 'logout',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Logout",
                  style: AppTextStyle.bodyText1.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.error,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Icon(
                  Icons.logout_outlined,
                  color: AppColor.error,
                  size: 16,
                )
              ],
            )),
      ],
    ).then((value) {
      if (value == 'logout') {
        ref.read(logoutControllerProvider.notifier).logout();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        InkWell(
          onTap: () => _showProfileMenu(context, ref),
          child: const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage("assets/main/ch_profile.png"),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: AppTextStyle.bodyText1.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 2.h),
              Text(greeting, style: AppTextStyle.bodyText2SubText),
            ],
          ),
        ),
        _IconCircle(
          icon: Icons.notifications_none_outlined,
          onTap: onNotificationTap,
        ),
        SizedBox(width: 8.w),
        _IconCircle(
          icon: Icons.qr_code_scanner_outlined,
          onTap: onScanTap,
        ),
      ],
    );
  }
}

class _IconCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconCircle({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }
}
