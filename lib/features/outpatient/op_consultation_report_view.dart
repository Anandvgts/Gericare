import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/op_consultation_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpConsultationReportView extends ConsumerWidget {
  final String consultationId;

  const OpConsultationReportView({
    super.key,
    required this.consultationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opConsultationReportControllerProvider(consultationId));
    final controller =
        ref.watch(opConsultationReportControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consultation Report',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              controller.reportData.encounterId,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        actions: [
          /// DOWNLOAD BUTTON
          _HeaderActionButton(
            icon: Icons.download_outlined,
            label: 'Download',
            onTap: controller.onDownload,
          ),
          SizedBox(width: 8.w),

          /// PRINT BUTTON
          _HeaderActionButton(
            icon: Icons.print_outlined,
            label: 'Print',
            onTap: controller.onPrint,
          ),
          SizedBox(width: 8.w),

          /// LETTERPAD PRINT BUTTON
          _HeaderActionButton(
            icon: Icons.description_outlined,
            label: 'Letterpad',
            onTap: controller.onLetterpadPrint,
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// REPORT CARD
              _ReportCard(controller: controller),
              SizedBox(height: 24.h),
            ],
          ),
        ),
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

/// Main report card
class _ReportCard extends StatelessWidget {
  final OpConsultationReportController controller;

  const _ReportCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    final report = controller.reportData;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER - HOSPITAL/CLINIC INFO
          _ReportHeader(report: report),

          Divider(height: 1, color: AppColor.containerOutline),

          /// PATIENT DETAILS GRID
          _PatientDetailsSection(report: report),

          Divider(height: 1, color: AppColor.containerOutline),

          /// PREVIOUS REPORTS / MEDICAL HISTORY SECTION
          _PreviousReportsSection(),

          Divider(height: 1, color: AppColor.containerOutline),

          /// MEDICATIONS TABLE
          _MedicationsSection(medicines: report.medicines),

          Divider(height: 1, color: AppColor.containerOutline),

          /// INVESTIGATIONS SECTION
          if (report.investigations.isNotEmpty) ...[
            _InvestigationsSection(investigations: report.investigations),
            Divider(height: 1, color: AppColor.containerOutline),
          ],

          /// INSTRUCTIONS SECTION
          _InstructionsSection(instructions: report.instructions),

          Divider(height: 1, color: AppColor.containerOutline),

          /// FOLLOW-UP SECTION
          if (report.followupDate != null) ...[
            _FollowupSection(
              date: report.followupDate!,
              notes: report.followupNotes,
            ),
            Divider(height: 1, color: AppColor.containerOutline),
          ],

          /// DOCTOR SIGNATURE
          _DoctorSignatureSection(report: report),
        ],
      ),
    );
  }
}

/// Report header with logo and clinic info
class _ReportHeader extends StatelessWidget {
  final ConsultationReportData report;

  const _ReportHeader({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(0.03),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          /// LOGO
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(
                Icons.local_hospital,
                color: AppColor.primary,
                size: 32,
              ),
            ),
          ),
          SizedBox(width: 14.w),

          /// CLINIC INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GeriCare Hospital',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  report.department,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Phone: 044-2345-6789 | Email: info@gericare.in',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColor.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          /// PRESCRIPTION LABEL
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'Rx',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Patient details section
class _PatientDetailsSection extends StatelessWidget {
  final ConsultationReportData report;

  const _PatientDetailsSection({required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Details',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            ),
          ),
          SizedBox(height: 12.h),

          /// DETAILS GRID
          Wrap(
            spacing: 24.w,
            runSpacing: 12.h,
            children: [
              _DetailItem(label: 'Name', value: report.patientName, width: 180.w),
              _DetailItem(label: 'UHID', value: report.uhid, width: 120.w),
              _DetailItem(label: 'Age / Gender', value: report.ageGender, width: 120.w),
              _DetailItem(label: 'Encounter ID', value: report.encounterId, width: 180.w),
              _DetailItem(label: 'Location', value: report.location, width: 150.w),
              _DetailItem(label: 'Date', value: report.date, width: 100.w),
            ],
          ),
        ],
      ),
    );
  }
}

/// Detail item widget
class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final double width;

  const _DetailItem({
    required this.label,
    required this.value,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColor.secondaryText,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Previous reports / Medical history section
class _PreviousReportsSection extends StatelessWidget {
  const _PreviousReportsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, size: 18, color: AppColor.primary),
              SizedBox(width: 8.w),
              Text(
                'Previous Reports (Medical History)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// DOCUMENT THUMBNAILS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _DocumentThumbnail(pageNumber: 1),
                SizedBox(width: 12.w),
                _DocumentThumbnail(pageNumber: 2),
                SizedBox(width: 12.w),
                _AddDocumentButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Document thumbnail
class _DocumentThumbnail extends StatelessWidget {
  final int pageNumber;

  const _DocumentThumbnail({required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 90.h,
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 28, color: AppColor.secondaryText),
          SizedBox(height: 4.h),
          Text(
            'Page $pageNumber',
            style: TextStyle(
              fontSize: 9.sp,
              color: AppColor.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

/// Add document button
class _AddDocumentButton extends StatelessWidget {
  const _AddDocumentButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 90.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColor.primary.withOpacity(0.3),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 24, color: AppColor.primary),
          SizedBox(height: 4.h),
          Text(
            'Add page',
            style: TextStyle(
              fontSize: 9.sp,
              color: AppColor.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Medications section with table
class _MedicationsSection extends StatelessWidget {
  final List<ReportMedicineItem> medicines;

  const _MedicationsSection({required this.medicines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medication_outlined, size: 18, color: const Color(0xFF4CAF50)),
              SizedBox(width: 8.w),
              Text(
                'Medications',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${medicines.length} items',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// TABLE HEADER
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30.w,
                  child: Text('#', style: _headerStyle()),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Medication', style: _headerStyle()),
                ),
                SizedBox(
                  width: 50.w,
                  child: Text('Dosage', style: _headerStyle()),
                ),
                SizedBox(
                  width: 40.w,
                  child: Text('Qty', style: _headerStyle()),
                ),
                SizedBox(
                  width: 100.w,
                  child: Text('Freq & Intake', style: _headerStyle()),
                ),
                SizedBox(
                  width: 60.w,
                  child: Text('Duration', style: _headerStyle()),
                ),
              ],
            ),
          ),

          /// TABLE ROWS
          ...medicines.asMap().entries.map((entry) {
            final index = entry.key;
            final medicine = entry.value;
            return _MedicineRow(
              index: index + 1,
              medicine: medicine,
              isLast: index == medicines.length - 1,
            );
          }),
        ],
      ),
    );
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF4CAF50),
    );
  }
}

/// Medicine table row
class _MedicineRow extends StatelessWidget {
  final int index;
  final ReportMedicineItem medicine;
  final bool isLast;

  const _MedicineRow({
    required this.index,
    required this.medicine,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: index.isOdd ? Colors.white : AppColor.background.withOpacity(0.5),
        border: Border(
          left: BorderSide(color: AppColor.containerOutline),
          right: BorderSide(color: AppColor.containerOutline),
          bottom: BorderSide(color: AppColor.containerOutline),
        ),
        borderRadius: isLast
            ? BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30.w,
                child: Text(
                  '$index.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColor.secondaryText,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  medicine.medication,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textOnPrimary,
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
                child: Text(
                  medicine.dosage,
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary),
                ),
              ),
              SizedBox(
                width: 40.w,
                child: Text(
                  medicine.quantity,
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary),
                ),
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  medicine.frequencyIntake,
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: Text(
                  medicine.duration,
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textOnPrimary),
                ),
              ),
            ],
          ),
          if (medicine.instruction != null) ...[
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                'Note: ${medicine.instruction}',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontStyle: FontStyle.italic,
                  color: AppColor.secondaryText,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Investigations section
class _InvestigationsSection extends StatelessWidget {
  final List<String> investigations;

  const _InvestigationsSection({required this.investigations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science_outlined, size: 18, color: const Color(0xFF00BCD4)),
              SizedBox(width: 8.w),
              Text(
                'Investigations Advised',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00BCD4),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: investigations.map((investigation) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BCD4).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.science, size: 14, color: const Color(0xFF00BCD4)),
                    SizedBox(width: 6.w),
                    Text(
                      investigation,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF00BCD4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Instructions section
class _InstructionsSection extends StatelessWidget {
  final List<String> instructions;

  const _InstructionsSection({required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.checklist, size: 18, color: const Color(0xFFFF9800)),
              SizedBox(width: 8.w),
              Text(
                'Instructions',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFF9800),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          ...instructions.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFF9800),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.textOnPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Follow-up section
class _FollowupSection extends StatelessWidget {
  final String date;
  final String? notes;

  const _FollowupSection({required this.date, this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: const Color(0xFF009688).withOpacity(0.03),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFF009688).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.calendar_today,
              size: 20,
              color: const Color(0xFF009688),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Follow-up Date',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColor.secondaryText,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                date,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF009688),
                ),
              ),
              if (notes != null) ...[
                SizedBox(height: 2.h),
                Text(
                  notes!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColor.secondaryText,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Doctor signature section
class _DoctorSignatureSection extends StatelessWidget {
  final ConsultationReportData report;

  const _DoctorSignatureSection({required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// SIGNATURE LINE
              Container(
                width: 150.w,
                height: 40.h,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColor.containerOutline, width: 1.5),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Signature',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.secondaryText,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              /// DOCTOR NAME
              Text(
                report.doctorName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary,
                ),
              ),
              SizedBox(height: 2.h),

              /// QUALIFICATION
              Text(
                report.doctorQualification,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColor.secondaryText,
                ),
              ),
              SizedBox(height: 2.h),

              /// REGISTRATION
              Text(
                report.doctorRegistration,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColor.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
