// import 'package:doctor/features/widgets/patient_header.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:doctor/core/styles/text_styles.dart';
// import 'package:doctor/features/widgets/app_bar_widget.dart';
// import 'al_need_assessment_controller.dart';

// class AlNeedAssessmentView extends ConsumerWidget {
//   final String patientId;

//   const AlNeedAssessmentView({
//     super.key,
//     required this.patientId,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final vm = ref.watch(alNeedAssessmentViewModelProvider(patientId));

//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBarWidget(
//         title: "AL Need Assessment",
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
//             SizedBox(height: 24.h),

//             /// CALLER & PATIENT DETAILS
//             _SectionCard(
//               title: "Caller & Patient Details",
//               rows: vm.callerDetails,
//             ),

//             SizedBox(height: 16.h),

//             /// FUNCTIONAL STATUS
//             _SectionCard(
//               title: "Functional Status",
//               rows: vm.functionalStatus,
//             ),

//             SizedBox(height: 16.h),

//             /// ASSESSMENT FORMS
//             _SectionCard(
//               title: "Assessment Forms",
//               rows: vm.assessmentForms,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:doctor/features/widgets/patient_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';

import 'al_need_assessment_controller.dart';

class AlNeedAssessmentView extends ConsumerWidget {
  final String patientId;

  const AlNeedAssessmentView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      alNeedAssessmentControllerProvider(patientId),
    );
    final controller = ref.watch(
      alNeedAssessmentControllerProvider(patientId).notifier,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarWidget(
        title: "AL Need Assessment",
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


            /// CALLER & PATIENT DETAILS
            _SectionCard(
              title: "Caller & Patient Details",
              rows: controller.callerDetails,
            ),

            SizedBox(height: 16.h),

            /// FUNCTIONAL STATUS
            _SectionCard(
              title: "Functional Status",
              rows: controller.functionalStatus,
            ),

            SizedBox(height: 16.h),

            /// ASSESSMENT FORMS
            _SectionCard(
              title: "Assessment Forms",
              rows: controller.assessmentForms,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<InfoRowData> rows;

  const _SectionCard({
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyText1.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 12.h),
          ...rows.map(
            (row) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      row.label,
                      style: AppTextStyle.bodyText2SubText,
                    ),
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  // gapH10,
                  Expanded(
                    flex: 5,
                    child: Text(
                      row.value,
                      style: AppTextStyle.bodyText1.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
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
