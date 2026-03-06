import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:doctor/features/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleCard extends StatelessWidget {
  final PatientSchedule schedule;

  const ScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationService.pushNamed(Routes.consultation,
            arguments: schedule.patientId);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Tag("Assisted Living"),
              const SizedBox(height: 12),
              Text(schedule.name,
                  style: AppTextStyle.bodyText1.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 6),
              Text(schedule.ward,
                  style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12)),
              if (schedule.completed) ...[
                const SizedBox(height: 12),
                _CompletedPill(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.colors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: AppTextStyle.smallText.copyWith(
              fontWeight: FontWeight.w600, color: context.colors.primary)),
    );
  }
}

class _CompletedPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHigh.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle,
              size: 16, color: context.colors.surfaceContainerHigh),
          SizedBox(width: 6),
          Text("Completed",
              style: AppTextStyle.smallText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: context.colors.surfaceContainerHigh)),
        ],
      ),
    );
  }
}
