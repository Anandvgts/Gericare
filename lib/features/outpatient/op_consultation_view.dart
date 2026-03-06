import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/dashboard/dashboard_controller.dart';
import 'package:doctor/features/outpatient/op_consultation_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpConsultationView extends ConsumerWidget {
  final PatientSchedule schedule;

  const OpConsultationView({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opConsultationControllerProvider(schedule));
    final controller =
        ref.watch(opConsultationControllerProvider(schedule).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBarWidget(
        title: "Out Patient",
        subTitle: schedule.name,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PATIENT HEADER CARD
            _PatientHeaderCard(
              name: schedule.name,
              gender: schedule.gender,
              age: schedule.age,
              uhid: schedule.uhid,
              onPrintSticker: controller.onPrintSticker,
            ),

            SizedBox(height: 20.h),

            /// ONGOING CONSULTATIONS SECTION
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.medical_services_outlined,
                      color: const Color(0xFF1976D2),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Ongoing Consultations',
                    style: AppTextStyle.bodyText1.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${controller.ongoingConsultations.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            /// ONGOING CONSULTATIONS LIST
            if (controller.ongoingConsultations.isEmpty)
              _EmptyStateCard(message: 'No ongoing consultations')
            else
              ...controller.ongoingConsultations.map((consultation) {
                return _ConsultationCard(
                  consultation: consultation,
                  isOngoing: true,
                  onView: () => controller.onViewConsultation(consultation),
                  onEdit: () => controller.onEditConsultation(consultation),
                  onDelete: () => controller.onDeleteConsultation(consultation),
                  onContinueAssessment: () =>
                      controller.onContinueAssessment(consultation),
                );
              }),

            SizedBox(height: 24.h),

            /// PAST CONSULTATIONS SECTION
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E5F5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.history,
                      color: AppColor.primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Past Consultations',
                    style: AppTextStyle.bodyText1.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  _ServiceTypeDropdown(
                    selectedValue: controller.selectedServiceType,
                    onChanged: controller.onServiceTypeChanged,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            /// PAST CONSULTATIONS LIST
            if (controller.pastConsultations.isEmpty)
              _EmptyStateCard(message: 'No past consultations found')
            else
              ...controller.pastConsultations.map((consultation) {
                return _ConsultationCard(
                  consultation: consultation,
                  isOngoing: false,
                  onView: () => controller.onViewConsultation(consultation),
                  onEdit: null,
                  onDelete: null,
                  onContinueAssessment: null,
                );
              }),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

/// Patient Header Card
class _PatientHeaderCard extends StatelessWidget {
  final String name;
  final String gender;
  final int age;
  final String uhid;
  final VoidCallback onPrintSticker;

  const _PatientHeaderCard({
    required this.name,
    required this.gender,
    required this.age,
    required this.uhid,
    required this.onPrintSticker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// AVATAR
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primary.withOpacity(0.2), AppColor.primary.withOpacity(0.1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'P',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.bodyText1.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      gender.toLowerCase() == 'male' ? Icons.male : Icons.female,
                      size: 16,
                      color: gender.toLowerCase() == 'male'
                          ? const Color(0xFF2196F3)
                          : const Color(0xFFE91E63),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      gender,
                      style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColor.secondaryText,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      '$age Yrs',
                      style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'UHID: $uhid',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// PRINT STICKER BUTTON
          InkWell(
            onTap: onPrintSticker,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.primary.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.print_outlined, size: 18, color: AppColor.primary),
                  SizedBox(width: 6.w),
                  Text(
                    'Print\nSticker',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state card
class _EmptyStateCard extends StatelessWidget {
  final String message;

  const _EmptyStateCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_outlined,
                size: 40,
                color: AppColor.secondaryText,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Results Found',
              style: AppTextStyle.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.error,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Service type dropdown
class _ServiceTypeDropdown extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const _ServiceTypeDropdown({
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.containerOutline),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            'All Services',
            style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 11.sp),
          ),
          icon: Icon(Icons.keyboard_arrow_down, size: 18, color: AppColor.secondaryText),
          isDense: true,
          items: const [
            DropdownMenuItem(value: 'all', child: Text('All')),
            DropdownMenuItem(value: 'consultation', child: Text('Consultation')),
            DropdownMenuItem(value: 'followup', child: Text('Follow-up')),
          ],
          onChanged: onChanged,
          style: AppTextStyle.bodyText2.copyWith(fontSize: 11.sp),
        ),
      ),
    );
  }
}

/// Consultation card widget - styled like ScheduleCard
class _ConsultationCard extends StatelessWidget {
  final OpConsultation consultation;
  final bool isOngoing;
  final VoidCallback onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onContinueAssessment;

  const _ConsultationCard({
    required this.consultation,
    required this.isOngoing,
    required this.onView,
    this.onEdit,
    this.onDelete,
    this.onContinueAssessment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onView,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TOP ROW - Tags and Status
                  Row(
                    children: [
                      /// S.NO Tag
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          '#${consultation.serialNo}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),
                        ),
                      ),

                      SizedBox(width: 8.w),

                      /// Service Category Tag
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4DE),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          consultation.serviceCategory,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEA9C00),
                          ),
                        ),
                      ),

                      const Spacer(),

                      /// Status Chip
                      _StatusChip(status: consultation.status),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  /// ENCOUNTER ID
                  Row(
                    children: [
                      Icon(Icons.tag, size: 16, color: AppColor.secondaryText),
                      SizedBox(width: 6.w),
                      Text(
                        'Encounter: ${consultation.encounterId}',
                        style: AppTextStyle.bodyText2.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  /// DOCTOR INFO
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: AppColor.secondaryText),
                      SizedBox(width: 6.w),
                      Text(
                        consultation.doctorName,
                        style: AppTextStyle.bodyText2.copyWith(fontSize: 12.sp),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColor.secondaryText,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        consultation.department,
                        style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  /// SERVICE INFO CARD
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FE),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.medical_services_outlined,
                            size: 20,
                            color: const Color(0xFF1976D2),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                consultation.serviceName,
                                style: AppTextStyle.bodyText2.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                consultation.centreName,
                                style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.schedule, size: 14, color: AppColor.secondaryText),
                            SizedBox(height: 2.h),
                            Text(
                              consultation.dateTime.replaceAll('\n', ' '),
                              style: AppTextStyle.caption.copyWith(fontSize: 10.sp),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ACTION BAR
            if (isOngoing)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    if (consultation.status == 'In Assessment')
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onContinueAssessment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.labletext,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Continue Assessment',
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                    if (consultation.isDue) ...[
                      SizedBox(width: 10.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColor.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColor.error.withOpacity(0.3)),
                        ),
                        child: Text(
                          'Due',
                          style: TextStyle(
                            color: AppColor.error,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],

                    const Spacer(),

                    /// ACTION ICONS
                    _ActionIconButton(
                      icon: Icons.visibility_outlined,
                      onTap: onView,
                    ),
                    if (onEdit != null) ...[
                      SizedBox(width: 6.w),
                      _ActionIconButton(
                        icon: Icons.edit_outlined,
                        onTap: onEdit!,
                      ),
                    ],
                    if (onDelete != null) ...[
                      SizedBox(width: 6.w),
                      _ActionIconButton(
                        icon: Icons.delete_outline,
                        onTap: onDelete!,
                        isDestructive: true,
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
}

/// Action icon button
class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionIconButton({
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColor.error.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isDestructive
                ? AppColor.error.withOpacity(0.3)
                : AppColor.containerOutline,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isDestructive ? AppColor.error : AppColor.secondaryText,
        ),
      ),
    );
  }
}

/// Status chip widget
class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        break;
      case 'in assessment':
        bgColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF1976D2);
        break;
      case 'cancelled':
        bgColor = const Color(0xFFFBE1EB);
        textColor = const Color(0xFFB4251E);
        break;
      default:
        bgColor = const Color(0xFFF5F5F5);
        textColor = const Color(0xFF757575);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
