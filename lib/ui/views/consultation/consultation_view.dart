import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/patient_header_card.dart';
import 'package:stacked/stacked.dart';

class ConsultationView extends StatelessWidget {
  const ConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ViewModelBuilder<ConsultationViewModel>.reactive(
      viewModelBuilder: () =>
          ConsultationViewModel(patientId: "patient_001"),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBarWidget(
            showBack: true,
            title: 'Consultation',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PatientHeader(
                  name: "Mr. Krishna Kumar",
                  gender: "Male",
                  age: 74,
                ),
                SizedBox(
                  height: 24,
                ),

                /// PATIENT DETAILS
                _SectionTitle("Patient Details"),
                GestureDetector(
                  onTap: viewModel.onAlNeedAssessmentTap,
                  child: _InfoCard(
                    icon: Icons.description_outlined,
                    title: "AL Need Assessment",
                    subtitle: "Created on 30th Jun 2025",
                  ),
                ),

                const SizedBox(height: 24),

                /// CONSULTATION
                _SectionTitle("Consultation"),
                GestureDetector(
                  onTap: viewModel.onConsultationTap,
                  child: _InfoCard(
                    icon: Icons.assignment_outlined,
                    title: "Consultation",
                    subtitle: "Updated on 1st Jul 2025",
                  ),
                ),

                const SizedBox(height: 8),

                GestureDetector(
                  onTap: viewModel.onViewHistoryTap,
                  child: Row(
                    children: [
                      Icon(Icons.history,
                          color: Theme.of(context).colorScheme.onSecondary),
                      const SizedBox(width: 8),
                      Text(
                        "View History",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// CASE SHEET
                _SectionTitle("Case Sheet"),
                GestureDetector(
                  onTap: viewModel.onCaseSheetTap,
                  child: _InfoCard(
                    icon: Icons.medical_information_outlined,
                    title: "Case Sheet",
                    subtitle: "Updated on 1st Jul 2025",
                  ),
                ),

                const SizedBox(height: 24),

                /// REPORTS
                _SectionTitle("Reports"),

                GestureDetector(
                  onTap: () => viewModel.onReportTap(
                    reportId: "cbc_001",
                    pdfUrl: "https://example.com/cbc_report.pdf",
                  ),
                  child: _ReportCard(
                    title: "CBC – Complete Blood Count",
                    subtitle: "Requested on 20th Jun 2025",
                    status: ReportStatus.newReport,
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => viewModel.onReportTap(
                    reportId: "cbc_002",
                    pdfUrl: "https://example.com/cbc_report_reviewed.pdf",
                  ),
                  child: _ReportCard(
                    title: "CBC – Complete Blood Count",
                    subtitle: "Requested on 20th Jun 2025",
                    status: ReportStatus.reviewed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: AppTextStyle.title1Bold
            .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: colors.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTextStyle.bodyText1
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

enum ReportStatus { newReport, reviewed }

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final ReportStatus status;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final chipColor =
        status == ReportStatus.newReport ? Colors.blue : Colors.orange;

    final chipText = status == ReportStatus.newReport ? "New" : "Reviewed";

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.bloodtype_outlined, size: 28, color: Colors.redAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyle.bodyText1
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style:
                        AppTextStyle.bodyText2SubText.copyWith(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: chipColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              chipText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: chipColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
