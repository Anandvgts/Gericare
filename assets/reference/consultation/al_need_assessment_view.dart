import 'package:flutter/material.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/patient_header_card.dart';
import 'package:stacked/stacked.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class AlNeedAssessmentView extends StatelessWidget {
  const AlNeedAssessmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<ConsultationViewModel>.reactive(
      viewModelBuilder: () => ConsultationViewModel(patientId: "patientId"),
      builder: (context, viewModel, _) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBarWidget(
                showBack: true,
                title: 'AL Need Assessment',
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(35),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    alignment: Alignment.centerLeft,
                    child: PatientHeader(
                      name: "Mr. Krishna Kumar",
                      gender: "Male",
                      age: 74,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: colors.background,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                child: Column(
                  children: [
                    _InfoCard(
                      title: "Caller & Patient Details",
                      rows: viewModel.callerDetails,
                    ),
                    const SizedBox(height: 16),
                    _InfoCard(
                      title: "Functional Status",
                      rows: viewModel.functionalStatus,
                    ),
                    const SizedBox(height: 16),
                    _InfoCard(
                      title: "Assessment Forms",
                      rows: viewModel.assessmentForms,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<InfoRowData> rows;

  const _InfoCard({
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.title1Bold.copyWith(
              fontSize: 16,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...rows.map((row) => _InfoRow(row)).toList(),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final InfoRowData data;

  const _InfoRow(this.data);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              data.label,
              style: AppTextStyle.bodyText2SubText,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              data.value,
              style: AppTextStyle.bodyText2Bold
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRowData {
  final String label;
  final String value;

  InfoRowData(this.label, this.value);
}

class _PatientHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String name;
  final String gender;
  final int age;
  final Color backgroundColor;

  _PatientHeaderDelegate({
    required this.name,
    required this.gender,
    required this.age,
    required this.backgroundColor,
  });

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: AppTextStyle.title1Bold),
          const SizedBox(height: 4),
          Text(
            "$gender  •  $age Yrs",
            style: AppTextStyle.bodyText2SubText,
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_) => false;
}
