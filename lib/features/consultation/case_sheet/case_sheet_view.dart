import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/patient_header.dart';

import 'case_sheet_controller.dart';

class CaseSheetView extends ConsumerWidget {
  final String patientId;

  const CaseSheetView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(caseSheetControllerProvider(patientId));
    final controller =
        ref.read(caseSheetControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarWidget(
        title: "Case Sheet",
        subTitle: "Last updated on Aug 21, 2025 – 8:45 AM",
        bottom: PatientHeader(
          name: controller.patientName,
          gender: controller.gender,
          age: controller.age,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LIST
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                CaseTile(
                  icon: "assets/main/case_sheet/medications.png",
                  title: "Medications",
                  onTap: controller.openMedications,
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/vitals.png",
                  title: "Vitals",
                  onTap: controller.openVitals,
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/fb_chart.png",
                  title: "Fluid Balance Chart",
                  onTap: controller.openFluidBalance,
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/vitals.png",
                  title: "Progress Notes",
                  onTap: controller.openProgressNotes,
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/care_plan.png",
                  title: "Care Plan",
                  onTap: () => controller.openCarePlan(patientId),
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/incident_report.png",
                  title: "Incident Report",
                  onTap: () => controller.openIncidentReport(patientId),
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/sugar_chart.png",
                  title: "Sugar Chart",
                  onTap: () => controller.openSugarChart(patientId),
                ),
                CaseTile(
                  icon: "assets/main/case_sheet/treatments.png",
                  title: "Treatments",
                  onTap: () => controller.openTreatments(patientId),
                ),
              ],
            ),
          ),

          /// BOTTOM CTA
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66B37A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                onPressed: controller.verifyCaseSheet,
                child: Text(
                  "Case Sheet Verified",
                  style: AppTextStyle.buttonLabel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CaseTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const CaseTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.surface,
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
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0x146369D1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Image.asset(
                icon,
                width: 30.w,
                height: 30.h,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.bodyText1.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.tertiaryFixed,
            ),
          ],
        ),
      ),
    );
  }
}
