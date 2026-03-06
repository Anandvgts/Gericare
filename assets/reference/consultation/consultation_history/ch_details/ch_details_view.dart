import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_history/ch_details/ch_details_view_model.dart';
import 'package:gericare_doctor/ui/widgets/consultation_section_card.dart';
import 'package:stacked/stacked.dart';

class ConsultationHistoryDetailsView extends StatelessWidget {
  const ConsultationHistoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ViewModelBuilder<ConsultationHistoryDetailsViewModel>.reactive(
      viewModelBuilder: () => ConsultationHistoryDetailsViewModel(),
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: AppBar(
              backgroundColor: colors.surface,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    color: colors.tertiaryFixed, size: 18),
                onPressed: () => Navigator.pop(context),
              ),
              titleSpacing: 0, // 🔥 removes extra gap
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Today",
                    style: AppTextStyle.title1Bold
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "3:30 AM, Jun 22,2025",
                    style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(72),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  alignment: Alignment.centerLeft,
                  child: _PatientHeader(
                    name: viewModel.doctorName,
                    speciality: viewModel.speciality,
                  ),
                ),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...viewModel.sections
                  .map((s) => ConsultationSectionCard(section: s)),
            ],
          ),
        );
      },
    );
  }
}

class _PatientHeader extends StatelessWidget {
  final String name;
  final String speciality;

  const _PatientHeader({
    required this.name,
    required this.speciality,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            "assets/main/ch_profile.png",
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: AppTextStyle.title1Bold
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(
              speciality,
              style: AppTextStyle.bodyText2SubText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9CA3AF)),
            ),
          ],
        )
      ],
    );
  }
}
