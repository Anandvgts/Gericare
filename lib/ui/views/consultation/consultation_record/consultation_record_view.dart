import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/consultation_record_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/consultation_section_card.dart';
import 'package:gericare_doctor/ui/widgets/patient_header_card.dart';
import 'package:stacked/stacked.dart';

class ConsultationRecordView extends StatelessWidget {
  final bool hasConsultationData;

  const ConsultationRecordView({super.key, required this.hasConsultationData});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ViewModelBuilder<ConsultationRecordViewModel>.reactive(
      viewModelBuilder: () =>
          ConsultationRecordViewModel(hasConsultationData: hasConsultationData),
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: colors.background,

          /// APP BAR
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBarWidget(
              showBack: true,
              title: 'Consultation',
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

          floatingActionButton: !vm.hasConsultationData
              ? AIAssistanceButton(
                  onPressed: vm.onAIAssistanceTap,
                )
              : null,
          bottomNavigationBar: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 16),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  vm.hasConsultationData
                      ? "Update Consultation"
                      : "Save Prescription",
                  style: AppTextStyle.buttonLabel,
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,

          /// BODY
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              vm.hasConsultationData ? _WithDataView(vm) : _WithoutDataView(vm),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}

class _WithoutDataView extends StatelessWidget {
  final ConsultationRecordViewModel vm;

  const _WithoutDataView(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuTile("Medical History", Icons.history,
            () => vm.openSection(ConsultationSectionType.medicalHistory)),
        _MenuTile("Vitals", Icons.monitor_heart,
            () => vm.openSection(ConsultationSectionType.vitals)),
        _MenuTile("Symptoms", Icons.coronavirus,
            () => vm.openSection(ConsultationSectionType.symptoms)),
        _MenuTile("Findings", Icons.healing,
            () => vm.openSection(ConsultationSectionType.findings)),
        _MenuTile("Diagnosis", Icons.assignment,
            () => vm.openSection(ConsultationSectionType.diagnosis)),
        _MenuTile("Medicines", Icons.medication,
            () => vm.openSection(ConsultationSectionType.medicines)),
        _MenuTile("Investigations", Icons.science,
            () => vm.openSection(ConsultationSectionType.investigations)),
        _MenuTile("Instructions", Icons.description,
            () => vm.openSection(ConsultationSectionType.instructions)),
        _MenuTile("Procedures", Icons.medical_services,
            () => vm.openSection(ConsultationSectionType.procedures)),
        _MenuTile("Follow Up", Icons.calendar_today,
            () => vm.openSection(ConsultationSectionType.followup)),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuTile(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0x146369D1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Color(0xFF6369D1),
                ),
                // child: Image.asset(section.icon, width: 18),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: AppTextStyle.title1Bold
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            Icon(Icons.chevron_right, color: colors.outline),
          ],
        ),
      ),
    );
  }
}

class AIAssistanceButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AIAssistanceButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF66C07A),
              Color(0xFF2F7D4A),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28),
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
            /// ✨ Sparkle PNG
            Image.asset(
              "assets/main/stars.png", // <-- your PNG
              width: 24,
              height: 24,
            ),

            const SizedBox(width: 10),

            const Text(
              "Start AI Assistance",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
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

class _WithDataView extends StatelessWidget {
  final ConsultationRecordViewModel vm;

  const _WithDataView(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: vm.sections
          .map((section) => ConsultationSectionCard(
              section: section,
              showChange: true,
              onChange: () => vm.openSection(section.type)))
          .toList(),
    );
  }
}
