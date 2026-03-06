import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'blood_sugar_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';
import 'package:doctor/features/widgets/date_divider.dart';

class BloodSugarView extends ConsumerWidget {
  final String patientId;

  const BloodSugarView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(bloodSugarControllerProvider(patientId));
    final controller =
        ref.watch(bloodSugarControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBarWidget(
        title: "Blood Sugar",
        subTitle: "Last Updated on Wed, Nov 7 2025",
        isCalnder: true,
        bottom: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.formattedSelectedDate,
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
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: controller.groupedLogs.entries.map((entry) {
          final date = entry.key;
          final items = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.isToday(date))
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    "Today",
                    style: AppTextStyle.bodyText1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                DateDivider(label: controller.shortDate(date)),

              ...items.map(
                (log) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: BloodSugarRow(log: log),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class BloodSugarRow extends StatelessWidget {
  final BloodSugarLog log;

  const BloodSugarRow({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TIME
        SizedBox(
          width: 72.w,
          child: Text(
            DateFormat('h:mm a').format(log.dateTime),
            style: AppTextStyle.bodyText2SubText.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        /// CARD
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                /// ICON
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF1FF),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/main/case_sheet/sugar_chart.png",
                    width: 22.w,
                  ),
                ),
                SizedBox(width: 12.w),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${log.value} mg/dl",
                            style: AppTextStyle.bodyText1.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            log.recordedBy,
                            style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        log.note,
                        style: AppTextStyle.bodyText2SubText.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
