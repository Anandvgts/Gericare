import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/diagnosis/diagnosis_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/app_chips.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:gericare_doctor/ui/widgets/search_bar_widget.dart';
import 'package:stacked/stacked.dart';

class DiagnosisView extends StatelessWidget {
  const DiagnosisView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiagnosisViewModel>.reactive(
      viewModelBuilder: () => DiagnosisViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: const AppBarWidget(
            showBack: true,
            title: "Diagnosis",
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Save Diagnosis",
              onPressed: () {},
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarField(
                  controller: vm.searchCtrl,
                  hintText: "Search Diagnosis",
                  onChanged: (_) => vm.notifyListeners(),
                ),

                const SizedBox(height: 16),

                /// SELECTED
                if (vm.selectedDiagnosis.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Selected Diagnosis", style: AppTextStyle.bodyText1),
                      Text("Past Medicines",
                          style: AppTextStyle.bodyText2
                              .copyWith(color: context.colors.onSecondary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: vm.selectedDiagnosis
                        .map(
                          (e) => AppChip(
                            label: e.name,
                            selected: true,
                            onTap: () {},
                            onRemove: () => vm.toggleDiagnosis(context, e.name),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],

                /// DIAGNOSIS LIST
                Text("Diagnosis", style: AppTextStyle.bodyText1),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...vm.filteredDiagnosis.map(
                      (e) => AppChip(
                        label: e,
                        selected: false,
                        onTap: () => vm.toggleDiagnosis(context, e),
                      ),
                    ),
                    if (vm.canCreate)
                      AppChip(
                        label: '+ Create "${vm.searchText}"',
                        selected: false,
                        onTap: () => vm.createDiagnosis(context),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DiagnosisDetailSheet extends StatefulWidget {
  final String title;
  final DiagnosisItem? existing;
  final ValueChanged<DiagnosisItem> onSave;

  const DiagnosisDetailSheet({
    super.key,
    required this.title,
    this.existing,
    required this.onSave,
  });

  @override
  State<DiagnosisDetailSheet> createState() => _DiagnosisDetailSheetState();
}

class _DiagnosisDetailSheetState extends State<DiagnosisDetailSheet> {
  String? since;
  String location = "";
  String option = "";

  final sinceOptions = [
    "0–3 Months",
    "3–6 Months",
    "6–12 Months",
    "1–2 Years",
  ];

  final options = [
    "On Treatment",
    "Not On Treatment",
    "Medicine on and Off",
  ];

  @override
  void initState() {
    super.initState();
    since = widget.existing?.since;
    location = widget.existing?.location ?? "";
    option = widget.existing?.option ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: AppTextStyle.title1Bold),
            const SizedBox(height: 16),
            Text("Since",
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),

            /// SINCE
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  hintText: 'Since',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.outline.withOpacity(0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.primary,
                      width: 1.2,
                    ),
                  )),
              value: since,
              items: sinceOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => since = v),
            ),

            const SizedBox(height: 16),
            Text("Location",
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),

            /// LOCATION
            TextField(
              decoration: InputDecoration(
                  hintText: 'Location',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.outline.withOpacity(0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colors.primary,
                      width: 1.2,
                    ),
                  )),
              controller: TextEditingController(text: location),
              onChanged: (v) => location = v,
            ),

            const SizedBox(height: 16),
            Text("Options",
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),

            /// OPTIONS
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options
                  .map(
                    (e) => AppChip(
                      label: e,
                      selected: option == e,
                      onTap: () => setState(() => option = e),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 24),

            PrimaryButton(
              label: "Continue",
              onPressed: () {
                widget.onSave(
                  DiagnosisItem(
                    name: widget.title,
                    since: since ?? "",
                    location: location,
                    option: option,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
