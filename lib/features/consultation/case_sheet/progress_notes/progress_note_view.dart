import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'progress_notes_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';

class ProgressNotesView extends ConsumerWidget {
  const ProgressNotesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(progressNotesControllerProvider);
    final controller =
        ref.watch(progressNotesControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBarWidget(
        title: "Progress Notes",
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
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.notes.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, index) {
          final note = controller.notes[index];
          return _ProgressNoteCard(
            note: note,
            time: controller.formatTime(note.dateTime),
          );
        },
      ),
    );
  }
}


class _ProgressNoteCard extends StatelessWidget {
  final ProgressNote note;
  final String time;

  const _ProgressNoteCard({
    required this.note,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(note.avatar),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.name,
                      style: AppTextStyle.bodyText1.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      time,
                      style: AppTextStyle.bodyText2SubText.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// NOTE TEXT
          Text(
            note.note,
            style: AppTextStyle.bodyText2.copyWith(
              fontSize: 13.sp,
              color: const Color(0xFF7A7A7A),
            ),
          ),
        ],
      ),
    );
  }
}
