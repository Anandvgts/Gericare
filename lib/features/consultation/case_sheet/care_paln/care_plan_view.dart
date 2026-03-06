import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'care_plan_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';

class CarePlanView extends ConsumerWidget {
  final String patientId;

  const CarePlanView({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(carePlanControllerProvider(patientId));
    final controller =
        ref.watch(carePlanControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBarWidget(
        title: "Care Plan History",
        subTitle: "Last Updated on Wed, Nov 7 2025",
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
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: controller.logs
            .map(
              (log) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _CarePlanTimelineRow(
                  log: log,
                  statusItems: controller.statusItems,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CarePlanTimelineRow extends StatelessWidget {
  final CarePlanLog log;
  final List<CarePlanStatusItem> statusItems;

  const _CarePlanTimelineRow({
    required this.log,
    required this.statusItems,
  });

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.4), // 🔥 blur backdrop feel
      builder: (_) => CarePlanBottomSheet(
        log: log,
        statusItems: statusItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72.w,
          child: Text(
            DateFormat('h:mm a').format(log.dateTime),
            style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () => _openBottomSheet(context),
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF1FF),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/main/case_sheet/care_plan.png",
                    ),
                  ),
                  SizedBox(width: 12.w),
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

class CarePlanBottomSheet extends StatelessWidget {
  final CarePlanLog log;
  final List<CarePlanStatusItem> statusItems;

  const CarePlanBottomSheet({
    super.key,
    required this.log,
    required this.statusItems,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Care Plan",
                style: AppTextStyle.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                DateFormat("EEE, MMM d yyyy, h:mm a").format(log.dateTime),
                style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
              ),
              SizedBox(height: 24.h),
              ...statusItems.map(
                (item) => _CarePlanStatusRow(item: item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarePlanStatusRow extends StatelessWidget {
  final CarePlanStatusItem item;

  const _CarePlanStatusRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final bgColor =
        item.isDone ? Color(0xFF4DB86B) : Color(0xFFB42318).withOpacity(0.1);
    final iconColor = item.isDone ? Colors.white : Color(0xFFB42318);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isDone ? Icons.check : Icons.close,
              size: 14,
              color: iconColor,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            item.label,
            style: AppTextStyle.bodyText1.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
