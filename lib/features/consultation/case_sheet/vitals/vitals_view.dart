import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/consultation/case_sheet/vitals/vitals_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsView extends ConsumerWidget {
  const VitalsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vitalsControllerProvider);
    final controller = ref.watch(vitalsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Vitals History",
        isCalnder: true,
        bottom: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.formattedSelectedDate),
            DashboardCalendar(
              selectedDate: controller.selectedDate,
              onDateSelected: controller.onDateSelected,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: controller.logs.map((log) {
          return TimelineRow(
            time: controller.formatTime(log.dateTime),
            child: VitalsHistoryCard(
              title: log.title,
              recordedBy: log.recordedBy,
              onTap: () => controller.openVitalsDetail(log),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class VitalsHistoryCard extends StatelessWidget {
  final String title;
  final String recordedBy;
  final VoidCallback onTap;

  const VitalsHistoryCard(
      {super.key,
      required this.title,
      required this.recordedBy,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
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
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F1FF),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/main/case_sheet/vitals.png',
                // width: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyText2Bold.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Recorded by $recordedBy",
                    style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class TimelineRow extends StatelessWidget {
  final String time;
  final Widget child;

  const TimelineRow({
    required this.time,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TIME
          SizedBox(
            width: 72,
            child: Text(
              time,
              style: AppTextStyle.bodyText2SubText
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),

          /// CARD
          Expanded(child: child),
        ],
      ),
    );
  }
}
