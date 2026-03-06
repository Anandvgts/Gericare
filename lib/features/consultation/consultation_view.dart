// import 'package:doctor/core/constants/images.dart';
// import 'package:doctor/locator.dart';
// import 'package:doctor/features/widgets/app_bar_widget.dart';
// import 'package:doctor/features/widgets/patient_header.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:doctor/core/styles/text_styles.dart';

// class ConsultationView extends ConsumerWidget {
//   final String patientId;

//   const ConsultationView({super.key, required this.patientId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final vm = ref.watch(consultationViewModelProvider(patientId));

//     return Scaffold(
//       appBar: AppBarWidget(
//         title: "Consultation",
//         bottom: PatientHeader(
//           name: vm.patientName,
//           gender: vm.gender,
//           age: vm.age,
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
     

//             /// PATIENT DETAILS
//             const _SectionTitle("Patient Details"),
//             _InfoCard(
//               iconPath: Images.alNeedAssessment,
//               title: "AL Need Assessment",
//               subtitle: "Created on 30th Jun 2025",
//               onTap: vm.onAlNeedAssessmentTap,
//             ),

//             SizedBox(height: 24.h),

//             /// CONSULTATION
//             const _SectionTitle("Consultation"),
//             _InfoCard(
//               iconPath: Images.consultation,
//               title: "Consultation",
//               subtitle: "Updated on 1st Jul 2025",
//               onTap: vm.onConsultationTap,
//             ),

//             SizedBox(height: 8.h),

//             GestureDetector(
//               onTap: vm.onViewHistoryTap,
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.history,
//                     color: Theme.of(context).colorScheme.onSecondary,
//                   ),
//                   SizedBox(width: 8.w),
//                   Text(
//                     "View History",
//                     style: AppTextStyle.bodyText1.copyWith(
//                       color: Theme.of(context).colorScheme.onSecondary,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 24.h),

//             /// CASE SHEET
//             const _SectionTitle("Case Sheet"),
//             _InfoCard(
//               iconPath: Images.caseSheet,
//               title: "Case Sheet",
//               subtitle: "Updated on 1st Jul 2025",
//               onTap: vm.onCaseSheetTap,
//             ),

//             SizedBox(height: 24.h),

//             /// REPORTS
//             const _SectionTitle("Reports"),
//             _ReportCard(
//               title: "CBC – Complete Blood Count",
//               subtitle: "Requested on 20th Jun 2025",
//               status: ReportStatus.newReport,
//               onTap: vm.onNewReportTap,
//             ),

//             SizedBox(height: 12.h),

//             _ReportCard(
//               title: "CBC – Complete Blood Count",
//               subtitle: "Requested on 20th Jun 2025",
//               status: ReportStatus.reviewed,
//               onTap: vm.onReviewedReportTap,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:doctor/core/constants/images.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/patient_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';

import 'consultation_controller.dart';

class ConsultationView extends ConsumerWidget {
  final String patientId;

  const ConsultationView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(consultationControllerProvider(patientId));
    final controller = ref.watch(
      consultationControllerProvider(patientId).notifier,
    );

    return Scaffold(
      appBar: AppBarWidget(
        title: "Consultation",
        bottom: PatientHeader(
          name: controller.patientName,
          gender: controller.gender,
          age: controller.age,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PATIENT DETAILS
            const _SectionTitle("Patient Details"),
            _InfoCard(
              iconPath: Images.alNeedAssessment,
              title: "AL Need Assessment",
              subtitle: "Created on 30th Jun 2025",
              onTap: controller.onAlNeedAssessmentTap,
            ),

            SizedBox(height: 24.h),

            /// CONSULTATION
            const _SectionTitle("Consultation"),
            _InfoCard(
              iconPath: Images.consultation,
              title: "Consultation",
              subtitle: "Updated on 1st Jul 2025",
              onTap: controller.onConsultationTap,
            ),

            SizedBox(height: 8.h),

            GestureDetector(
              onTap: controller.onViewHistoryTap,
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    color:
                        Theme.of(context).colorScheme.onSecondary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "View History",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            /// CASE SHEET
            const _SectionTitle("Case Sheet"),
            _InfoCard(
              iconPath: Images.caseSheet,
              title: "Case Sheet",
              subtitle: "Updated on 1st Jul 2025",
              onTap: controller.onCaseSheetTap,
            ),

            SizedBox(height: 24.h),

            /// REPORTS
            const _SectionTitle("Reports"),
            _ReportCard(
              title: "CBC – Complete Blood Count",
              subtitle: "Requested on 20th Jun 2025",
              status: ReportStatus.newReport,
              onTap: controller.onNewReportTap,
            ),

            SizedBox(height: 12.h),

            _ReportCard(
              title: "CBC – Complete Blood Count",
              subtitle: "Requested on 20th Jun 2025",
              status: ReportStatus.reviewed,
              onTap: controller.onReviewedReportTap,
            ),
          ],
        ),
      ),
    );
  }
}


class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyle.bodyText1.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _InfoCard({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 30.w,
              height: 30.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodyText1.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style:
                      AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum ReportStatus { newReport, reviewed }

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ReportStatus status;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = status == ReportStatus.newReport
        ? context.colors.onTertiary
        : context.colors.onTertiaryFixed;

    final chipText = status == ReportStatus.newReport ? "New" : "Reviewed";

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              Images.reports,
              width: 30.w,
              height: 30.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// TITLE (takes remaining space)
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodyText1.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(width: 8.w),

                      /// STATUS CHIP
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: chipColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          chipText,
                          style: AppTextStyle.smallText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: chipColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style:
                        AppTextStyle.bodyText2SubText.copyWith(fontSize: 12.sp),
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


