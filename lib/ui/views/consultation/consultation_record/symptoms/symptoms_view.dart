import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/symptoms/symptoms_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/app_chips.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:gericare_doctor/ui/widgets/search_bar_widget.dart';
import 'package:stacked/stacked.dart' show ViewModelBuilder;

class SymptomsView extends StatelessWidget {
  const SymptomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SymptomsViewModel>.reactive(
      viewModelBuilder: () => SymptomsViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar:  AppBarWidget(
            showBack: true,
            title: "Symptoms",
          ),

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Save Symptoms",
              onPressed: vm.canSaveSymptoms ? () {} : null,
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarField(
                  
                  controller: vm.searchCtrl,
                  hintText: "Search",
                  onChanged: (_) => vm.notifyListeners(),
                ),

                const SizedBox(height: 16),

                if (vm.selectedSymptoms.isNotEmpty) ...[
                  Text("Selected Symptoms",
                      style: AppTextStyle.bodyText1),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: vm.selectedSymptoms.map((s) {
                      return 
                      AppChip(
                        label: s.name,
                        selected: true,
                        showWarning: !s.isComplete,

                        /// ONLY !
                        onWarningTap: () {
                          vm.openSymptomDetail(
                            context,
                            s.name,
                            existing: s,
                          );
                        },

                        onRemove: () {
                          vm.selectedSymptoms.remove(s);
                          vm.notifyListeners();
                        },
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 24),

                Text("Symptoms", style: AppTextStyle.bodyText1),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...vm.filteredSymptoms.map(
                      (e) => AppChip(
                        label: e,
                        onTap: () => vm.toggleSymptom(context, e),
                      ),
                    ),
                    if (vm.canCreate)
                      AppChip(
                        label: '+ Create "${vm.searchText}"',
                        onTap: () {
                          vm.allSymptoms.add(vm.searchText);
                          vm.toggleSymptom(context, vm.searchText);
                          vm.searchCtrl.clear();
                        },
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


class SymptomDetailsBottomSheet extends StatefulWidget {
  final SymptomItem symptom;
  final ValueChanged<SymptomItem> onSave;

  const SymptomDetailsBottomSheet({
    super.key,
    required this.symptom,
    required this.onSave,
  });

  @override
  State<SymptomDetailsBottomSheet> createState() =>
      _SymptomDetailsBottomSheetState();
}

class _SymptomDetailsBottomSheetState
    extends State<SymptomDetailsBottomSheet> {
  final sinceOptions = ['1 day', '2 days', '3 days', '1 week'];
  final descriptionOptions = ['To Rule Out', 'Moderate', 'Severe'];

  bool get canSave =>
      widget.symptom.since != null &&
      widget.symptom.description != null;

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

            Text(widget.symptom.name,
                style: AppTextStyle.title1Bold),

            const SizedBox(height: 20),

            /// SINCE
            DropdownButtonFormField<String>(
              value: widget.symptom.since,
              decoration: const InputDecoration(
                labelText: 'Since',
                border: OutlineInputBorder(),
              ),
              items: sinceOptions
                  .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                widget.symptom.since = v;
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION
            Text('Description',
                style: AppTextStyle.bodyText2Bold),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: descriptionOptions.map((e) {
                final selected = widget.symptom.description == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: colors.primary.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: selected
                        ? colors.primary
                        : colors.onSurface,
                  ),
                  onSelected: (_) {
                    widget.symptom.description = e;
                    setState(() {});
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            PrimaryButton(
              label: 'Save',
              onPressed: canSave
                  ? () {
                      widget.onSave(widget.symptom);
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
