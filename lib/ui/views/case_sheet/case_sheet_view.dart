import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/case_sheet/case_sheet_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/patient_header_card.dart';
import 'package:stacked/stacked.dart';

class CaseSheetView extends StatelessWidget {
  const CaseSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ViewModelBuilder<CaseSheetViewModel>.reactive(
      viewModelBuilder: () => CaseSheetViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: AppBarWidget(
              showBack: true,
              title: "Case Sheet",
              subtitle: "Last updated on Aug 21, 2025 – 8:45 AM",
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

          /// BODY
          body: Column(
            children: [
              /// LIST
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    _CaseTile(
                      icon: "assets/main/case_sheet/medications.png",
                      title: "Medications",
                      onTap: vm.openMedications,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/vitals.png",
                      title: "Vitals",
                      onTap: vm.openVitals,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/fb_chart.png",
                      title: "Fluid Balance Chart",
                      onTap: vm.openFluidBalance,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/vitals.png",
                      title: "Progress Notes",
                      onTap: vm.openProgressNotes,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/care_plan.png",
                      title: "Care Plan",
                      onTap: vm.openCarePlan,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/incident_report.png",
                      title: "Incident Report",
                      onTap: vm.openIncidentReport,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/sugar_chart.png",
                      title: "Sugar Chart",
                      onTap: vm.openSugarChart,
                    ),
                    _CaseTile(
                      icon: "assets/main/case_sheet/treatments.png",
                      title: "Treatments",
                      onTap: vm.openTreatments,
                    ),
                  ],
                ),
              ),

              /// BOTTOM BUTTON
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF66B37A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Case Sheet Verified",
                      style: AppTextStyle.buttonLabel.copyWith(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CaseTile extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const _CaseTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

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
          borderRadius: BorderRadius.circular(14),
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  width: 22,
                  height: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w600),
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
