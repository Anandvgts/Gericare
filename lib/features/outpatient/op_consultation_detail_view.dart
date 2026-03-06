import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/op_consultation_controller.dart';
import 'package:doctor/features/outpatient/op_consultation_detail_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpConsultationDetailView extends ConsumerWidget {
  final OpConsultation consultation;

  const OpConsultationDetailView({
    super.key,
    required this.consultation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opConsultationDetailControllerProvider(consultation));
    final controller =
        ref.watch(opConsultationDetailControllerProvider(consultation).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBarWidget(
        title: 'Nandanam',
        actions: [
          /// INCOMPLETE VITALS CHIP
          if (!controller.isVitalsComplete)
            Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColor.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.error.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded, size: 14, color: AppColor.error),
                  SizedBox(width: 4.w),
                  Text(
                    'Incomplete Vitals',
                    style: TextStyle(
                      color: AppColor.error,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          /// PRINT BUTTON
          _HeaderActionButton(
            icon: Icons.print_outlined,
            label: 'Print',
            onTap: controller.onPrint,
          ),

          SizedBox(width: 8.w),

          /// DOWNLOAD BUTTON
          _HeaderActionButton(
            icon: Icons.download_outlined,
            label: 'Download',
            onTap: controller.onDownload,
          ),

          SizedBox(width: 8.w),

          /// BACK BUTTON
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, size: 14, color: Colors.white),
                SizedBox(width: 4.w),
                Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),
        ],
        bottom: _PatientInfoHeader(consultation: consultation),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDEBAR MENU
          _SidebarMenu(
            selectedIndex: controller.selectedMenuIndex,
            onMenuTap: controller.onMenuTap,
            controller: controller,
          ),

          /// VERTICAL DIVIDER
          Container(width: 1, color: AppColor.containerOutline),

          /// CONTENT AREA
          Expanded(
            child: _ContentArea(
              selectedIndex: controller.selectedMenuIndex,
              controller: controller,
            ),
          ),
        ],
      ),

      /// BOTTOM SUBMIT BUTTON
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
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
          onPressed: controller.onSubmitConsultation,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text(
            'Submit Consultation',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

/// Patient info header (below app bar)
class _PatientInfoHeader extends StatelessWidget implements PreferredSizeWidget {
  final OpConsultation consultation;

  const _PatientInfoHeader({required this.consultation});

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColor.containerOutline)),
      ),
      child: Row(
        children: [
          /// AVATAR
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                'N',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          /// NAME & INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nandanam',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textOnPrimary,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.male, size: 14, color: AppColor.secondaryText),
                    SizedBox(width: 4.w),
                    Text(
                      'Male',
                      style: TextStyle(fontSize: 11.sp, color: AppColor.secondaryText),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.person_outline, size: 14, color: AppColor.secondaryText),
                    SizedBox(width: 4.w),
                    Text(
                      '50 Years',
                      style: TextStyle(fontSize: 11.sp, color: AppColor.secondaryText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Header action button
class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HeaderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sidebar menu widget
class _SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onMenuTap;
  final OpConsultationDetailController controller;

  const _SidebarMenu({
    required this.selectedIndex,
    required this.onMenuTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: controller.menuItems.length,
        itemBuilder: (context, index) {
          final sectionType = controller.menuItems[index];
          final isSelected = selectedIndex == index;
          final icon = controller.getSectionIcon(sectionType);
          final label = controller.getSectionTitle(sectionType);

          return InkWell(
            onTap: () => onMenuTap(index),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary.withOpacity(0.08)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: isSelected
                    ? Border.all(color: AppColor.primary.withOpacity(0.3))
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.primary.withOpacity(0.15)
                          : AppColor.background,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: isSelected ? AppColor.primary : AppColor.secondaryText,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? AppColor.primary : AppColor.textOnPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: isSelected ? AppColor.primary : AppColor.secondaryText.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Content area widget - shows different content based on selected section
class _ContentArea extends StatelessWidget {
  final int selectedIndex;
  final OpConsultationDetailController controller;

  const _ContentArea({
    required this.selectedIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final sectionType = controller.menuItems[selectedIndex];

    switch (sectionType) {
      case ConsultationSectionType.aiSummary:
        return _AISummaryContent(controller: controller);
      case ConsultationSectionType.consultationReport:
        return _ConsultationReportContent();
      case ConsultationSectionType.medicalHistory:
        return _MedicalHistoryContent();
      case ConsultationSectionType.vitals:
        return _VitalsContent();
      case ConsultationSectionType.symptoms:
        return _EmptyStateContent(
          title: 'Symptoms',
          message: 'No symptoms recorded',
          icon: Icons.sick_outlined,
        );
      case ConsultationSectionType.findings:
        return _EmptyStateContent(
          title: 'Examination Findings',
          message: 'No findings recorded',
          icon: Icons.search,
        );
      case ConsultationSectionType.diagnosis:
        return _EmptyStateContent(
          title: 'Diagnosis',
          message: 'No diagnosis recorded',
          icon: Icons.assignment_outlined,
        );
      case ConsultationSectionType.medicines:
        return _MedicinesContent();
      case ConsultationSectionType.instructionsInvestigationsProcedures:
        return _InstructionsInvestigationsProceduresContent();
      case ConsultationSectionType.followup:
        return _FollowupContent();
    }
  }
}

/// AI Summary content
class _AISummaryContent extends StatelessWidget {
  final OpConsultationDetailController controller;

  const _AISummaryContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    final summary = controller.aiSummary;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Text(
            'Previous Consultation AI Summary',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textOnPrimary,
            ),
          ),

          SizedBox(height: 20.h),

          /// PATIENT INFORMATION
          _SectionCard(
            title: 'Patient Information',
            children: [
              _InfoRow(label: 'Name', value: summary.patientName),
              _InfoRow(label: 'Age / DOB', value: summary.ageDobGender),
              _InfoRow(label: 'MRN / UHID', value: summary.mrnUhid),
              _InfoRow(label: 'Date of Visit', value: summary.dateOfVisit),
              _InfoRow(label: 'Consulting Doctor', value: summary.consultingDoctor),
              _InfoRow(label: 'Department / Speciality', value: summary.departmentSpecialty),
            ],
          ),

          SizedBox(height: 16.h),

          /// VITALS
          _SectionCard(
            title: 'Vitals',
            children: summary.vitals.entries.map((entry) {
              return _InfoRow(label: entry.key, value: entry.value);
            }).toList(),
          ),

          SizedBox(height: 16.h),

          /// CHIEF COMPLAINTS / SYMPTOMS
          _SectionCard(
            title: 'Chief Complaints / Symptoms',
            children: summary.chiefComplaints.map((complaint) {
              return _BulletPoint(text: complaint);
            }).toList(),
          ),

          SizedBox(height: 16.h),

          /// DIAGNOSIS
          _SectionCard(
            title: 'Diagnosis',
            children: summary.diagnosis.map((diagnosis) {
              return _BulletPoint(text: diagnosis);
            }).toList(),
          ),

          SizedBox(height: 16.h),

          /// CLINICAL FINDINGS
          _SectionCard(
            title: 'Clinical Findings / Examination',
            children: summary.clinicalFindings.map((finding) {
              return _BulletPoint(text: finding);
            }).toList(),
          ),

          SizedBox(height: 16.h),

          /// INVESTIGATIONS / LAB RESULTS
          _SectionCard(
            title: 'Investigations / Lab Results',
            children: [
              _BulletPoint(text: 'CBC (Pending)'),
              _BulletPoint(text: 'RFT (Pending)'),
              _BulletPoint(text: 'Vit B12 (Pending)'),
            ],
          ),

          SizedBox(height: 16.h),

          /// FOLLOW-UP
          _SectionCard(
            title: 'Follow-Up',
            children: [
              _BulletPoint(text: 'Follow-up instructions: Next Review in 1 month.'),
            ],
          ),

          SizedBox(height: 16.h),

          /// PRESCRIBED MEDICATIONS TABLE
          _PrescribedMedicationsTable(),

          SizedBox(height: 16.h),

          /// UPLOADED FILE
          _UploadedFileSection(),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

/// Section card widget
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.textOnPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        ...children,
      ],
    );
  }
}

/// Info row widget
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            margin: EdgeInsets.only(top: 5.h, right: 8.w),
            decoration: BoxDecoration(
              color: AppColor.textOnPrimary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColor.textOnPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColor.textOnPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bullet point widget
class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            margin: EdgeInsets.only(top: 5.h, right: 8.w),
            decoration: BoxDecoration(
              color: AppColor.textOnPrimary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Prescribed Medications Table
class _PrescribedMedicationsTable extends StatelessWidget {
  const _PrescribedMedicationsTable();

  @override
  Widget build(BuildContext context) {
    final medications = [
      {'medication': 'I AMLOSAFE', 'dosage': '5 ml', 'route': 'PO', 'frequency': '1-0-0-1', 'instructions': '-', 'duration': 'Kids'},
      {'medication': '7 ANXIT', 'dosage': '0.25', 'route': '-', 'frequency': '0-0-1-0', 'instructions': '-', 'duration': 'Kids'},
      {'medication': 'IN RENEMNE PLUS', 'dosage': '2ml', 'route': 'I.M', 'frequency': '0-0-0-0', 'instructions': 'BF, X, AF, STOP', 'duration': '-'},
      {'medication': 'T. RA20', 'dosage': '20 mgs', 'route': '-', 'frequency': '0-0-0-0', 'instructions': 'BF, (empty starch)', 'duration': '35 days.'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prescribed Medications',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.textOnPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.containerOutline),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              /// TABLE HEADER
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Row(
                  children: [
                    _TableHeader('Medication', flex: 2),
                    _TableHeader('Dosage', flex: 1),
                    _TableHeader('Route', flex: 1),
                    _TableHeader('Frequency\n(M-A-E-N)', flex: 2),
                    _TableHeader('Instructions\n(BF/AF)', flex: 2),
                    _TableHeader('Duration', flex: 1),
                  ],
                ),
              ),

              /// TABLE ROWS
              ...medications.map((med) => _MedicationRow(med)),
            ],
          ),
        ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;
  final int flex;

  const _TableHeader(this.text, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.secondaryText,
        ),
      ),
    );
  }
}

class _MedicationRow extends StatelessWidget {
  final Map<String, String> med;

  const _MedicationRow(this.med);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColor.containerOutline)),
      ),
      child: Row(
        children: [
          _TableCell(med['medication']!, flex: 2),
          _TableCell(med['dosage']!, flex: 1),
          _TableCell(med['route']!, flex: 1),
          _TableCell(med['frequency']!, flex: 2),
          _TableCell(med['instructions']!, flex: 2),
          _TableCell(med['duration']!, flex: 1),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final int flex;

  const _TableCell(this.text, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(fontSize: 9.sp, color: AppColor.textOnPrimary),
      ),
    );
  }
}

/// Uploaded File Section
class _UploadedFileSection extends StatelessWidget {
  const _UploadedFileSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uploaded File',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.textOnPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: 80.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColor.containerOutline),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.description_outlined, size: 32, color: AppColor.secondaryText),
              SizedBox(height: 8.h),
              Text(
                'Page 1',
                style: TextStyle(fontSize: 10.sp, color: AppColor.secondaryText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Consultation Report Content placeholder
class _ConsultationReportContent extends StatelessWidget {
  const _ConsultationReportContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_outlined, size: 48, color: AppColor.secondaryText),
          SizedBox(height: 16.h),
          Text(
            'Tap to view Consultation Report',
            style: TextStyle(fontSize: 14.sp, color: AppColor.secondaryText),
          ),
        ],
      ),
    );
  }
}

/// Medical History Content - 6 cards grid
class _MedicalHistoryContent extends StatelessWidget {
  const _MedicalHistoryContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medical History',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 20.h),

          /// GRID OF CARDS
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.1,
            children: [
              _MedicalHistoryCard(
                title: 'Medical Problems',
                icon: Icons.favorite_outline,
                iconColor: const Color(0xFFE91E63),
              ),
              _MedicalHistoryCard(
                title: 'Allergies',
                icon: Icons.warning_amber_outlined,
                iconColor: const Color(0xFFFF9800),
              ),
              _MedicalHistoryCard(
                title: 'Family History',
                icon: Icons.people_outline,
                iconColor: const Color(0xFF2196F3),
              ),
              _MedicalHistoryCard(
                title: 'Lifestyle & Habits',
                icon: Icons.local_dining_outlined,
                iconColor: const Color(0xFF4CAF50),
              ),
              _MedicalHistoryCard(
                title: 'Past Procedures',
                icon: Icons.medical_services_outlined,
                iconColor: const Color(0xFF9C27B0),
              ),
              _MedicalHistoryCard(
                title: 'Risk Factors',
                icon: Icons.info_outline,
                iconColor: const Color(0xFF607D8B),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MedicalHistoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const _MedicalHistoryCard({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColor.containerOutline)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: iconColor),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textOnPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// EMPTY STATE
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link_off, size: 28, color: AppColor.secondaryText.withOpacity(0.5)),
                SizedBox(height: 8.h),
                Text(
                  'No data recorded',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondaryText,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Click Add button to add record',
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: AppColor.secondaryText.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Vitals Content - 3 columns
class _VitalsContent extends StatelessWidget {
  const _VitalsContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vitals',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 20.h),

          /// VITALS GRID
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// BLOOD PRESSURE
                _VitalsCard(
                  title: 'Blood Pressure',
                  icon: Icons.favorite_outline,
                  iconColor: const Color(0xFFE91E63),
                  items: [
                    {'label': 'Lying', 'value': '--'},
                    {'label': 'Sitting', 'value': '--'},
                    {'label': 'Standing', 'value': '--'},
                  ],
                ),
                SizedBox(width: 12.w),

                /// HEART & RESPIRATORY
                _VitalsCard(
                  title: 'Heart & Respiratory',
                  icon: Icons.monitor_heart_outlined,
                  iconColor: const Color(0xFFF44336),
                  items: [
                    {'label': 'Pulse', 'value': '--'},
                    {'label': 'Respiratory Rate', 'value': '--'},
                    {'label': 'SPO₂', 'value': '--'},
                    {'label': 'Temperature', 'value': '--'},
                  ],
                ),
                SizedBox(width: 12.w),

                /// MEASUREMENTS
                _VitalsCard(
                  title: 'Measurements',
                  icon: Icons.straighten,
                  iconColor: const Color(0xFF2196F3),
                  items: [
                    {'label': 'Blood Sugar', 'value': '--'},
                    {'label': 'Height', 'value': '--'},
                    {'label': 'Weight', 'value': '--'},
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VitalsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Map<String, String>> items;

  const _VitalsCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColor.containerOutline)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: iconColor),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textOnPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ITEMS
          ...items.map((item) => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColor.containerOutline.withOpacity(0.5))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['label']!,
                      style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary),
                    ),
                    Text(
                      item['value']!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryText,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

/// Empty state content for sections without data
class _EmptyStateContent extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const _EmptyStateContent({
    required this.title,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textOnPrimary,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.secondaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Medicines Content
class _MedicinesContent extends StatelessWidget {
  const _MedicinesContent();

  @override
  Widget build(BuildContext context) {
    return _EmptyStateContent(
      title: 'Medicines',
      message: 'No medicines prescribed',
      icon: Icons.medication_outlined,
    );
  }
}

/// Instructions, Investigations & Procedures Content
class _InstructionsInvestigationsProceduresContent extends StatelessWidget {
  const _InstructionsInvestigationsProceduresContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Instructions, Investigations & Procedures',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 20.h),

          /// INSTRUCTIONS
          Text(
            'Instructions',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          _BlueBulletPoint('Inadequate beta glucan intake'),
          _BlueBulletPoint('Adolescent and young adult oncology care'),

          SizedBox(height: 24.h),

          /// INVESTIGATIONS
          Text(
            'Investigations',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'No investigations ordered',
              style: TextStyle(fontSize: 12.sp, color: AppColor.secondaryText),
            ),
          ),

          SizedBox(height: 24.h),

          /// PROCEDURES
          Text(
            'Procedures',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'No procedures scheduled',
              style: TextStyle(fontSize: 12.sp, color: AppColor.secondaryText),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlueBulletPoint extends StatelessWidget {
  final String text;

  const _BlueBulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            margin: EdgeInsets.only(top: 4.h, right: 10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.sp, color: AppColor.textOnPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Follow-up Content
class _FollowupContent extends StatelessWidget {
  const _FollowupContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Follow Up Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 20.h),

          /// REVIEW FOLLOW UP DATE
          Text(
            'Review Follow Up Date',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.secondaryText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '--',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.textOnPrimary,
            ),
          ),

          SizedBox(height: 20.h),

          /// FOLLOW UP NOTE
          _NoteField(title: 'Follow Up Note'),

          SizedBox(height: 16.h),

          /// PRESCRIPTION NOTES
          _NoteField(title: 'Prescription Notes'),

          SizedBox(height: 16.h),

          /// DOCTOR NOTES
          _NoteField(title: 'Doctor Notes'),

          SizedBox(height: 24.h),

          /// UPLOADED FILE
          Text(
            'Uploaded File',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textOnPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 90.w,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description_outlined, size: 36, color: AppColor.secondaryText),
                SizedBox(height: 8.h),
                Text(
                  'Page 1',
                  style: TextStyle(fontSize: 11.sp, color: AppColor.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteField extends StatelessWidget {
  final String title;

  const _NoteField({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.textOnPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColor.containerOutline),
          ),
          child: Text(
            'Note:',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.secondaryText,
            ),
          ),
        ),
      ],
    );
  }
}
