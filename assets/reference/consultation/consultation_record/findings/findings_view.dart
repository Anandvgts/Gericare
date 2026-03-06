import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/findings/findings_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/app_chips.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:gericare_doctor/ui/widgets/search_bar_widget.dart';
import 'package:stacked/stacked.dart';

class FindingsView extends StatelessWidget {
  const FindingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FindingsViewModel>.reactive(
      viewModelBuilder: () => FindingsViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: const AppBarWidget(
            showBack: true,
            title: "Findings",
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Save Findings",
              onPressed: vm.canSaveFindings ? () {} : null,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarField(
                  controller: vm.searchCtrl,
                  hintText: "Search Findings",
                  onChanged: (_) => vm.notifyListeners(),
                ),

                /// SEARCH

                const SizedBox(height: 16),

                if (vm.selectedFindings.isNotEmpty) ...[
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

                  /// SELECTED FINDINGS
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: vm.selectedFindings.map((f) {
                      return AppChip(
                        label: f.name,
                        selected: true,
                        showWarning: !f.isComplete,

                        /// ⚠️ tap ONLY opens bottom sheet
                        onWarningTap: () {
                          vm.openFindingDetail(
                            context,
                            f.name,
                            existing: f,
                          );
                        },

                        /// normal tap does nothing
                        onTap: f.isComplete
                            ? null
                            : () {
                                vm.openFindingDetail(
                                  context,
                                  f.name,
                                  existing: f,
                                );
                              },

                        onRemove: () {
                          vm.selectedFindings.remove(f);
                          vm.notifyListeners();
                        },
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 24),

                /// FINDINGS LIST
                Text("Findings", style: AppTextStyle.bodyText1),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...vm.filteredFindings.map(
                      (e) => AppChip(
                        label: e,
                        selected: false,
                        onTap: () => vm.toggleFinding(context, e),
                      ),
                    ),
                    if (vm.canCreate)
                      AppChip(
                        label: '+ Create "${vm.searchText}"',
                        selected: false,
                        onTap: () => vm.createFinding(context),
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

class FindingDetailsBottomSheet extends StatefulWidget {
  final FindingItem finding;
  final ValueChanged<FindingItem> onSave;

  const FindingDetailsBottomSheet({
    super.key,
    required this.finding,
    required this.onSave,
  });

  @override
  State<FindingDetailsBottomSheet> createState() =>
      _FindingDetailsBottomSheetState();
}

class _FindingDetailsBottomSheetState extends State<FindingDetailsBottomSheet> {
  late TextEditingController notesCtrl;

  final durations = ['2 days', '3 days', '1 week'];
  final severities = ['Mild', 'Moderate', 'Severe'];

  @override
  void initState() {
    super.initState();
    notesCtrl = TextEditingController(text: widget.finding.notes);
  }

  bool get canSave =>
      notesCtrl.text.trim().isNotEmpty &&
      widget.finding.duration != null &&
      widget.finding.severity != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DRAG HANDLE
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// TITLE
            Text(widget.finding.name, style: AppTextStyle.title1Bold),

            const SizedBox(height: 20),

            /// NOTES
            TextField(
              controller: notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                widget.finding.notes = v;
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            /// DURATION
            DropdownButtonFormField<String>(
              value: widget.finding.duration,
              decoration: const InputDecoration(
                labelText: 'Duration',
                border: OutlineInputBorder(),
              ),
              items: durations
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (v) {
                widget.finding.duration = v;
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            /// SEVERITY
            Text('Severity', style: AppTextStyle.bodyText2Bold),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: severities.map((e) {
                final selected = widget.finding.severity == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: colors.primary.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: selected ? colors.onSurface : Color(0xFF7A7A7A),
                  ),
                  onSelected: (_) {
                    widget.finding.severity = e;
                    setState(() {});
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            /// SAVE
            PrimaryButton(
              label: 'Save',
              onPressed: canSave
                  ? () {
                      widget.onSave(widget.finding);
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
