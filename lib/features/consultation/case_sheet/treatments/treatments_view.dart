import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'treatments_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';
import 'package:doctor/features/widgets/date_divider.dart';

class TreatmentsView extends ConsumerWidget {
  final String patientId;

  const TreatmentsView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(treatmentsControllerProvider(patientId));
    final controller =
        ref.watch(treatmentsControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBarWidget(
        title: "Treatments",
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
        children: controller.groupedTreatments.entries.map((entry) {
          final date = entry.key;
          final items = entry.value;
          final isToday = controller.isToday(date);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isToday)
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
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: TreatmentRow(item: item),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}


class TreatmentRow extends StatelessWidget {
  final TreatmentItem item;

  const TreatmentRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TIME
        SizedBox(
          width: 72.w,
          child: Text(
            DateFormat('h:mm a').format(item.dateTime),
            style: AppTextStyle.bodyText2SubText
                .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
        ),

        SizedBox(width: 12.w),

        /// CARD
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ICON
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F1FF),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/main/treatment_history.png",
                    width: 25.w,
                    height: 25.h,
                  ),
                ),
                SizedBox(width: 12.w),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTextStyle.bodyText1.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.subtitle.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          item.subtitle,
                          style: AppTextStyle.bodyText2SubText.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                      SizedBox(height: 6.h),
                      _info("Therapist", item.therapist),
                      _info("Referred", item.referredBy),
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

  Widget _info(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50.w, // 👈 FIXED LABEL WIDTH (adjust as needed)
          child: Text(
            label,
            style: AppTextStyle.bodyText2SubText.copyWith(
              fontSize: 10.sp,
            ),
          ),
        ),
        Text(
          " : ",
          style: AppTextStyle.bodyText2SubText.copyWith(
            fontSize: 10.sp,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.bodyText1.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

