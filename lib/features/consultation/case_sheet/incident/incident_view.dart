import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'incident_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';

class IncidentView extends ConsumerWidget {
  final String patientId;

  const IncidentView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(incidentControllerProvider(patientId));
    final controller =
        ref.watch(incidentControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBarWidget(
        title: "Incidents",
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
        children: controller.incidents
            .map(
              (log) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _IncidentRow(
                  log: log,
                  onTap: () => controller.openIncident(log),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _IncidentRow extends StatelessWidget {
  final IncidentLog log;
  final VoidCallback onTap;

  const _IncidentRow({
    required this.log,
    required this.onTap,
  });

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
            style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
          ),
        ),

        SizedBox(width: 12.w),

        /// CARD
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: onTap,
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
                      "assets/main/case_sheet/incident_report.png",
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  /// TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log.title,
                          style: AppTextStyle.bodyText1.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Recorded by ${log.recordedBy}",
                          style: AppTextStyle.bodyText2SubText.copyWith(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
