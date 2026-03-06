import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'medications_controller.dart';

class MedicationsView extends ConsumerWidget {
  const MedicationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(medicationsControllerProvider);
    final controller = ref.read(medicationsControllerProvider.notifier);

    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBarWidget(
        title: "Medications",
        // subTitle: "Last Updated on Wed, Nov 7 2025",
        isCalnder: true,
        bottom: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.formattedDate,
              style: AppTextStyle.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            DashboardCalendar(
              selectedDate: controller.selectedDate,
              onDateSelected: controller.onDateSelected,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomActions(
        onAdd: controller.onAddMedication,
        onUpdate: controller.onUpdate,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MedicationSection("Morning", controller.morning),
          const SizedBox(height: 16),
          _MedicationSection("After Noon", controller.afternoon),
          const SizedBox(height: 16),
          _MedicationSection("Night", controller.night),
        ],
      ),
    );
  }
}

class _MedicationSection extends StatelessWidget {
  final String title;
  final List items;

  const _MedicationSection(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x296C849D)),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final isLast = i == items.length - 1;
              return Column(
                children: [
                  _MedicationTile(item: items[i]),
                  if (!isLast)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: const Divider(height: 1, color: Color(0xFFE6E8EC)),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _MedicationTile extends StatelessWidget {
  final MedicationItem item;

  const _MedicationTile({required this.item});

  Color get statusColor {
    switch (item.status) {
      case MedicationStatus.taken:
        return AppColor.successList;
      case MedicationStatus.refused:
        return AppColor.errorList;
      case MedicationStatus.skipped:
        return AppColor.skipedLabel;
    }
  }

  String get statusLabel {
    switch (item.status) {
      case MedicationStatus.taken:
        return "Taken";
      case MedicationStatus.refused:
        return "Refused";
      case MedicationStatus.skipped:
        return "Skipped";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _StatusIcon(status: item.status, color: statusColor),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.name} – ${item.dose}",
                  style: AppTextStyle.bodyText1.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.subtitle,
                  style: AppTextStyle.bodyText2SubText.copyWith(
                    fontSize: 12.sp,
                    color: item.status == MedicationStatus.refused
                        ? statusColor
                        : Color(0xFF9CA3AF),
                  ),
                ),
                if (item.status == MedicationStatus.skipped)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      statusLabel,
                      style: AppTextStyle.bodyText2SubText.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Icon(
            Icons.remove_circle_outline,
            size: 25,
            color: AppColor.errorListIcon,
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final MedicationStatus status;
  final Color color;

  const _StatusIcon({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MedicationStatus.taken:
        return _circle(Icons.check, color, AppColor.successListIcon);
      case MedicationStatus.refused:
        return _circle(Icons.close, color, AppColor.errorListIcon);
      case MedicationStatus.skipped:
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            shape: BoxShape.circle,
          ),
        );
    }
  }

  Widget _circle(IconData icon, Color bg, Color iconColor) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
      child: Icon(icon, size: 16, color: iconColor),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onUpdate;

  const _BottomActions({
    required this.onAdd,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.transparent),
                backgroundColor: Color(0x2940AE72),
                foregroundColor: const Color(0xFF3BB05E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onPressed: onAdd,
              child: const Text("Add Medication"),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3BB05E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              onPressed: onUpdate,
              child: const Text("Update"),
            ),
          ),
        ],
      ),
    );
  }
}
