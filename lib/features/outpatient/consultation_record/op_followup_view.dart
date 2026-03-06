import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_followup_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OpFollowupView extends ConsumerWidget {
  final String consultationId;

  const OpFollowupView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opFollowupControllerProvider(consultationId));
    final controller = ref.watch(opFollowupControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Follow Up'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton(
          onPressed: controller.canSave ? controller.onSaveFollowup : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Follow Up', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            /// QUICK SELECT
            Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quick Select', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: ['1 Week', '2 Weeks', '1 Month', '2 Months', '3 Months', '6 Months'].map((duration) {
                    final selected = controller.selectedQuickOption == duration;
                    return ChoiceChip(
                      label: Text(duration),
                      selected: selected,
                      selectedColor: AppColor.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: selected ? AppColor.primary : AppColor.textOnPrimary,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      onSelected: (_) => controller.selectQuickOption(duration),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// OR PICK DATE
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Or Pick a Date', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: () => controller.pickDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.containerOutline),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: AppColor.secondaryText, size: 20),
                        SizedBox(width: 12.w),
                        Text(
                          controller.selectedDate != null
                              ? DateFormat('EEEE, MMMM d, y').format(controller.selectedDate!)
                              : 'Select Date',
                          style: AppTextStyle.bodyText2.copyWith(
                            color: controller.selectedDate != null ? AppColor.textOnPrimary : AppColor.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// NOTES
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notes', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12.h),
                TextField(
                  controller: controller.notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Add follow-up notes...',
                    hintStyle: AppTextStyle.bodyText2SubText,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColor.containerOutline),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// REMINDER
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Send Reminder', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                    Text('SMS reminder to patient', style: AppTextStyle.caption.copyWith(color: AppColor.secondaryText)),
                  ],
                ),
                Switch(
                  value: controller.sendReminder,
                  onChanged: controller.toggleReminder,
                  activeColor: AppColor.primary,
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
