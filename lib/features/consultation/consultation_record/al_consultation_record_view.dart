import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/consultation/consultation_record/al_consultation_record_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/patient_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlConsultationRecordView extends ConsumerWidget {
  final String patientId;

  const AlConsultationRecordView({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alConsultationRecordControllerProvider(patientId));
    final controller = ref.watch(alConsultationRecordControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBarWidget(
        title: 'Consultation',
        bottom: PatientHeader(
          name: controller.patientName,
          gender: controller.gender,
          age: controller.age,
        ),
      ),
      floatingActionButton: !controller.hasConsultationData
          ? _AIAssistanceButton(onPressed: controller.onAIAssistanceTap)
          : null,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.onSaveConsultation,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.r),
            ),
          ),
          child: Text(
            controller.hasConsultationData ? 'Update Consultation' : 'Save Prescription',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            if (controller.hasConsultationData)
              _WithDataView(controller: controller)
            else
              _WithoutDataView(controller: controller),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

/// View without consultation data - shows menu tiles
class _WithoutDataView extends StatelessWidget {
  final AlConsultationRecordController controller;

  const _WithoutDataView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuTile(
          title: 'Medical History',
          icon: Icons.history,
          onTap: () => controller.openSection(AlConsultationSectionType.medicalHistory),
        ),
        _MenuTile(
          title: 'Vitals',
          icon: Icons.monitor_heart,
          onTap: () => controller.openSection(AlConsultationSectionType.vitals),
        ),
        _MenuTile(
          title: 'Symptoms',
          icon: Icons.sick_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.symptoms),
        ),
        _MenuTile(
          title: 'Examination Findings',
          icon: Icons.search,
          onTap: () => controller.openSection(AlConsultationSectionType.findings),
        ),
        _MenuTile(
          title: 'Diagnosis',
          icon: Icons.assignment_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.diagnosis),
        ),
        _MenuTile(
          title: 'Medicines',
          icon: Icons.medication_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.medicines),
        ),
        _MenuTile(
          title: 'Investigations',
          icon: Icons.science_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.investigations),
        ),
        _MenuTile(
          title: 'Instructions',
          icon: Icons.description_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.instructions),
        ),
        _MenuTile(
          title: 'Procedures',
          icon: Icons.medical_services_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.procedures),
        ),
        _MenuTile(
          title: 'Follow Up',
          icon: Icons.calendar_today_outlined,
          onTap: () => controller.openSection(AlConsultationSectionType.followup),
        ),
      ],
    );
  }
}

/// View with consultation data - shows filled sections
class _WithDataView extends StatelessWidget {
  final AlConsultationRecordController controller;

  const _WithDataView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.sections.map((section) {
        return _SectionCard(
          section: section,
          onEdit: () => controller.openSection(section.type),
        );
      }).toList(),
    );
  }
}

/// Menu tile widget
class _MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6369D1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(icon, color: const Color(0xFF6369D1), size: 22),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.bodyText1.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColor.secondaryText, size: 22),
          ],
        ),
      ),
    );
  }
}

/// Section card widget (for filled data)
class _SectionCard extends StatelessWidget {
  final AlConsultationSection section;
  final VoidCallback onEdit;

  const _SectionCard({
    required this.section,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
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
              color: _getHeaderColor(section.type).withOpacity(0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
            ),
            child: Row(
              children: [
                Icon(section.icon, size: 20, color: _getHeaderColor(section.type)),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    section.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _getHeaderColor(section.type),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.containerOutline),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_outlined, size: 14, color: AppColor.secondaryText),
                        SizedBox(width: 4.w),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// CONTENT
          if (section.items.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: section.items.map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          margin: EdgeInsets.only(top: 6.h, right: 10.w),
                          decoration: BoxDecoration(
                            color: _getHeaderColor(section.type).withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: AppTextStyle.bodyText2.copyWith(fontSize: 13.sp),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Text(
                'No data added',
                style: AppTextStyle.bodyText2SubText.copyWith(
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getHeaderColor(AlConsultationSectionType type) {
    switch (type) {
      case AlConsultationSectionType.medicalHistory:
        return const Color(0xFF9C27B0);
      case AlConsultationSectionType.vitals:
        return const Color(0xFFE91E63);
      case AlConsultationSectionType.symptoms:
        return const Color(0xFFFF5722);
      case AlConsultationSectionType.findings:
        return const Color(0xFF795548);
      case AlConsultationSectionType.diagnosis:
        return const Color(0xFF2196F3);
      case AlConsultationSectionType.medicines:
        return const Color(0xFF4CAF50);
      case AlConsultationSectionType.investigations:
        return const Color(0xFF00BCD4);
      case AlConsultationSectionType.instructions:
        return const Color(0xFFFF9800);
      case AlConsultationSectionType.procedures:
        return const Color(0xFF673AB7);
      case AlConsultationSectionType.followup:
        return const Color(0xFF009688);
    }
  }
}

/// AI Assistance floating button
class _AIAssistanceButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AIAssistanceButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF66C07A), Color(0xFF2F7D4A)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2F7D4A).withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: Colors.white, size: 22),
            SizedBox(width: 10.w),
            Text(
              'Start AI Assistance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
