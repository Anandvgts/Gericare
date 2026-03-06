import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/consultation/consultation_history/consultation_history_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ConsultationHistoryView extends ConsumerWidget {
  final String patientId;

  const ConsultationHistoryView({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(consultationHistoryControllerProvider(patientId));
    final controller = ref.watch(consultationHistoryControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBarWidget(
        title: 'Consultation History',
        subTitle: 'Last Updated on ${DateFormat('EEE, MMM d yyyy').format(controller.lastUpdated)}',
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => ListView(
          padding: EdgeInsets.all(16.w),
          children: controller.groupedHistory.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final date = entry.value.key;
            final items = entry.value.value;
            final isLatest = index == 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// DATE HEADER
                if (isLatest)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Text(
                      _getDayLabel(date),
                      style: AppTextStyle.bodyText1.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  _DateDivider(label: _getFullDateLabel(date)),

                /// HISTORY ITEMS
                ...items.map(
                  (item) => _HistoryItemCard(
                    item: item,
                    onTap: () => controller.openHistoryDetails(item),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getDayLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';

    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[date.weekday - 1];
  }

  String _getFullDateLabel(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }
}

/// Date divider widget
class _DateDivider extends StatelessWidget {
  final String label;

  const _DateDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColor.containerOutline)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Text(
              label,
              style: AppTextStyle.bodyText2.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: Divider(color: AppColor.containerOutline)),
        ],
      ),
    );
  }
}

/// History item card widget
class _HistoryItemCard extends StatelessWidget {
  final ConsultationHistoryItem item;
  final VoidCallback onTap;

  const _HistoryItemCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(0.05),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  topRight: Radius.circular(14.r),
                ),
              ),
              child: Row(
                children: [
                  /// TIME
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      DateFormat('h:mm a').format(item.dateTime),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  /// TYPE TAG
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: _getTypeColor(item.type).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      item.type,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: _getTypeColor(item.type),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Icon(
                    Icons.chevron_right,
                    size: 22,
                    color: AppColor.secondaryText,
                  ),
                ],
              ),
            ),

            /// CONTENT
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// DOCTOR INFO
                  Row(
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            item.doctorName.split(' ').last[0],
                            style: TextStyle(
                              color: AppColor.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.doctorName,
                              style: AppTextStyle.bodyText1.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              item.speciality,
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

                  /// SUMMARY
                  Text(
                    item.summary,
                    style: AppTextStyle.bodyText2.copyWith(
                      fontSize: 13.sp,
                      color: AppColor.secondaryText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  /// TAGS (diagnosis + medicines count)
                  if (item.diagnosis.isNotEmpty || item.medicines.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: [
                        if (item.diagnosis.isNotEmpty)
                          _InfoChip(
                            icon: Icons.assignment_outlined,
                            label: '${item.diagnosis.length} Diagnosis',
                            color: const Color(0xFF2196F3),
                          ),
                        if (item.medicines.isNotEmpty)
                          _InfoChip(
                            icon: Icons.medication_outlined,
                            label: '${item.medicines.length} Medicines',
                            color: const Color(0xFF4CAF50),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'consultation':
        return const Color(0xFF2196F3);
      case 'follow-up':
        return const Color(0xFF9C27B0);
      case 'routine checkup':
        return const Color(0xFF4CAF50);
      case 'specialist consultation':
        return const Color(0xFFFF9800);
      default:
        return AppColor.primary;
    }
  }
}

/// Info chip widget
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
