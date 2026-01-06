import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/medical_history/medical_history_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class MedicalHistoryView extends StatelessWidget {
  const MedicalHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<MedicalHistoryViewModel>.reactive(
      viewModelBuilder: () => MedicalHistoryViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: const AppBarWidget(
            showBack: true,
            title: 'Consultation',
          ),
          bottomNavigationBar: _SubmitButton(),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: const [
              MedicalProblemsSection(),
              SizedBox(height: 24),
              AllergiesSection(),
              SizedBox(height: 24),
              FamilyHistorySection(),
              SizedBox(height: 24),
              LifestyleSection(),
              SizedBox(height: 24),
              ProcedureSection(),
              SizedBox(height: 24),
              RiskFactorSection()
            ],
          ),
        );
      },
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onAddNotes;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onAddNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.bodyText1),
        GestureDetector(
          onTap: onAddNotes,
          child: Text(
            "Add Notes",
            style: AppTextStyle.bodyText2.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colors.onSecondary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF66B37D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: const Text(
            "Submit Medical History",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class MedicalProblemsSection extends ViewModelWidget<MedicalHistoryViewModel> {
  const MedicalProblemsSection({super.key});

  @override
  Widget build(BuildContext context, vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Medical Problems",
          onAddNotes: () => vm.openAddNotes(context, "Medical Problems"),
        ),
        const SizedBox(height: 6),
        Text(
          "Select medical Problems",
          style: AppTextStyle.bodyText2SubText,
        ),
        const SizedBox(height: 12),

        /// CHIPS
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...vm.selectedProblems.map(
              (p) => _MedicalChip(
                label: p.name,
                selected: true,
                onTap: () => vm.openProblemDetail(context, p),
                onRemove: () => vm.removeProblem(p.name),
              ),
            ),
            ...vm.availableProblems.map(
              (p) => _MedicalChip(
                label: p,
                selected: false,
                onTap: () => vm.openProblemDetail(
                  context,
                  MedicalProblem(name: p, duration: "", medicine: ""),
                ),
              ),
            ),
            _AddMoreChip(
              onTap: () => vm.openAddMoreProblems(context),
            ),
          ],
        ),

        const SizedBox(height: 16),

        ...vm.selectedProblems.map(
          (p) => MedicalProblemItem(
            problem: p,
            onChange: () => vm.openProblemDetail(context, p),
          ),
        ),
        const Divider(height: 32),
      ],
    );
  }
}

class MedicalProblemItem extends StatelessWidget {
  final MedicalProblem problem;
  final VoidCallback onChange;

  const MedicalProblemItem({
    super.key,
    required this.problem,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  problem.name,
                  style: AppTextStyle.bodyText1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration : ${problem.duration}\nMedication : ${problem.medicine}",
                      style: AppTextStyle.bodyText2SubText,
                    ),

                    /// CHANGE LINK
                    GestureDetector(
                      onTap: onChange,
                      child: Text(
                        "Change",
                        style: AppTextStyle.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colors.onSecondary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class MedicalProblemDetailSheet extends StatefulWidget {
  final MedicalProblem? existing;
  final String title;
  final ValueChanged<MedicalProblem> onSave;

  const MedicalProblemDetailSheet({
    super.key,
    required this.title,
    this.existing,
    required this.onSave,
  });

  @override
  State<MedicalProblemDetailSheet> createState() =>
      _MedicalProblemDetailSheetState();
}

class _MedicalProblemDetailSheetState extends State<MedicalProblemDetailSheet> {
  String? duration;
  bool hasMedication = true;
  String? medicine;

  final durations = const [
    "0–3 Months",
    "3–6 Months",
    "6–12 Months",
    "1–2 Years",
    "2–3 Years",
    "3–4 Years",
  ];

  final medicines = const [
    "G2K (400 mg)",
    "G2K (200 mg)",
    "Dolo 650",
    "Paracetamol",
  ];

  @override
  void initState() {
    super.initState();

    duration = widget.existing?.duration;

    final existingMed = widget.existing?.medicine;
    if (existingMed != null && existingMed.isNotEmpty) {
      medicine = existingMed;
    } else {
      medicine = null;
    }

    hasMedication = existingMed != null && existingMed.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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

            /// Duration
            const Text("Duration"),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: duration,
              hint: const Text("Select"),
              items: durations
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => duration = v),
            ),

            const SizedBox(height: 16),

            /// Medication Yes / No
            const Text("Medication"),
            const SizedBox(height: 6),
            Row(
              children: [
                _YesNoChip(
                  label: "Yes",
                  selected: hasMedication,
                  onTap: () => setState(() => hasMedication = true),
                ),
                const SizedBox(width: 8),
                _YesNoChip(
                  label: "No",
                  selected: !hasMedication,
                  onTap: () => setState(() => hasMedication = false),
                ),
              ],
            ),

            if (hasMedication) ...[
              const SizedBox(height: 16),
              const Text("Medicines"),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: medicine,
                hint: const Text("Select"),
                items: medicines
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => medicine = v),
              ),
            ],

            const SizedBox(height: 24),
            PrimaryButton(
              label: "Done",
              onPressed: () {
                widget.onSave(
                  MedicalProblem(
                    name: widget.title,
                    duration: duration ?? "",
                    medicine: hasMedication ? medicine ?? "" : "",
                  ),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _MedicalChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  const _MedicalChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? Colors.pink : Colors.grey.shade400;
    final bgColor = selected ? const Color(0xFFFFEEF2) : Colors.transparent;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: AppTextStyle.bodyText2),
            if (selected) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.close, size: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AddMoreChip extends StatelessWidget {
  final VoidCallback onTap;

  const _AddMoreChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add, size: 16),
            SizedBox(width: 4),
            Text("Add More"),
          ],
        ),
      ),
    );
  }
}

class _YesNoChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _YesNoChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFEEF2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.pink : Colors.grey.shade400,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  final String title;
  final String value;

  const _KeyValueRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(title, style: AppTextStyle.bodyText2Bold),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.bodyText2SubText,
            ),
          ),
        ],
      ),
    );
  }
}

class AllergiesSection extends ViewModelWidget<MedicalHistoryViewModel> {
  const AllergiesSection({super.key});

  @override
  Widget build(BuildContext context, vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Allergies",
          onAddNotes: () => vm.openAddNotes(context, "Allergies"),
        ),
        const SizedBox(height: 6),
        Text(
          "Do you have any allergies ?",
          style: AppTextStyle.bodyText2SubText,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _YesNoChip(
              label: "Yes",
              selected: vm.hasAllergy == true,
              onTap: () {
                vm.setHasAllergy(true);
              },
            ),
            const SizedBox(width: 12),
            _YesNoChip(
              label: "No",
              selected: vm.hasAllergy == false,
              onTap: () {
                vm.setHasAllergy(false);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (vm.hasAllergy == true) ...[
          _KeyValueRow(
            title: "General Allergies",
            value: vm.generalAllergies.isEmpty
                ? "--"
                : vm.generalAllergies.join(", "),
          ),
          _KeyValueRow(
            title: "Drug Allergies",
            value:
                vm.drugAllergies.isEmpty ? "--" : vm.drugAllergies.join(", "),
          ),
          GestureDetector(
            onTap: () => vm.openAllergiesSheet(context),
            // {
            //   showModalBottomSheet(
            //     context: context,
            //     isScrollControlled: true,
            //     backgroundColor: Colors.transparent,
            //     builder: (_) => AllergiesBottomSheet(
            //       general: vm.generalAllergies,
            //       drug: vm.drugAllergies,
            //       onSave: (data) {
            //         vm.generalAllergies = data["general"]!;
            //         vm.drugAllergies = data["drug"]!;
            //         vm.notifyListeners();
            //       },
            //     ),
            //   );
            // },

            child: Text(
              "Change",
              style: AppTextStyle.bodyText2.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colors.onSecondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
        const Divider(height: 32),
      ],
    );
  }
}

class AllergiesBottomSheet extends StatefulWidget {
  final List<String> general;
  final List<String> drug;
  final List<String> generalOptions;
  final List<String> drugOptions;
  final void Function({
    required List<String> general,
    required List<String> drug,
    required List<String> generalOptions,
    required List<String> drugOptions,
  }) onSave;

  const AllergiesBottomSheet({
    super.key,
    required this.general,
    required this.drug,
    required this.generalOptions,
    required this.drugOptions,
    required this.onSave,
  });

  @override
  State<AllergiesBottomSheet> createState() => _AllergiesBottomSheetState();
}

class _AllergiesBottomSheetState extends State<AllergiesBottomSheet> {
  late List<String> general;
  late List<String> drug;
  late List<String> generalOptions;
  late List<String> drugOptions;

  @override
  void initState() {
    super.initState();
    general = [...widget.general];
    drug = [...widget.drug];
    generalOptions = [...widget.generalOptions];
    drugOptions = [...widget.drugOptions];
  }

  void toggle(List<String> list, String value) {
    setState(() {
      list.contains(value) ? list.remove(value) : list.add(value);
    });
  }

  void openAddMore(
    BuildContext context, {
    required List<String> available,
    required List<String> selected,
    required ValueChanged<List<String>> onSelectedChange,
    required ValueChanged<List<String>> onOptionsChange,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMoreBottomSheet(
        availableItems: available,
        selectedItems: selected,
        onDone: (list) {
          // 🔥 CRITICAL FIX
          final updatedOptions = {
            ...available,
            ...list,
          }.toList();

          onOptionsChange(updatedOptions);
          onSelectedChange(list);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Text("Allergies", style: AppTextStyle.title1Bold),
            const SizedBox(height: 16),

            /// ---------------- GENERAL ----------------
            const Text("General Allergies"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...generalOptions.map(
                  (e) => _MedicalChip(
                    label: e,
                    selected: general.contains(e),
                    onTap: () => toggle(general, e),
                    onRemove: () => toggle(general, e),
                  ),
                ),

                /// + ADD MORE
                _AddMoreChip(
                  onTap: () => openAddMore(
                    context,
                    available: generalOptions,
                    selected: general,
                    onSelectedChange: (list) {
                      setState(() => general = list);
                    },
                    onOptionsChange: (opts) {
                      setState(() => generalOptions = opts);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// ---------------- DRUG ----------------
            const Text("Drug Allergies"),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...drugOptions.map(
                  (e) => _MedicalChip(
                    label: e,
                    selected: drug.contains(e),
                    onTap: () => toggle(drug, e),
                    onRemove: () => toggle(drug, e),
                  ),
                ),

                /// + ADD MORE
                _AddMoreChip(
                  onTap: () => openAddMore(
                    context,
                    available: drugOptions,
                    selected: drug,
                    onSelectedChange: (list) {
                      setState(() => drug = list);
                    },
                    onOptionsChange: (opts) {
                      setState(() => drugOptions = opts);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// DONE
            PrimaryButton(
              label: "Done",
              onPressed: () {
                widget.onSave(
                  general: general,
                  drug: drug,
                  generalOptions: generalOptions,
                  drugOptions: drugOptions,
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

class FamilyHistorySection extends ViewModelWidget<MedicalHistoryViewModel> {
  const FamilyHistorySection({super.key});

  @override
  Widget build(BuildContext context, vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Family History",
          onAddNotes: () => vm.openAddNotes(context, "Family History"),
        ),
        const SizedBox(height: 6),
        Text(
          "What are the illnesses that run in your family ?",
          style: AppTextStyle.bodyText2SubText,
        ),
        const SizedBox(height: 12),

        /// CHIPS
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...vm.familyIllnessOptions.map((illness) {
              final selected =
                  vm.familyHistory.any((e) => e.illness == illness);

              return _MedicalChip(
                label: illness,
                selected: selected,
                onTap: () => vm.openFamilyHistorySheet(context, illness),
                onRemove:
                    selected ? () => vm.removeFamilyHistory(illness) : null,
              );
            }),
            _AddMoreChip(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => AddMoreBottomSheet(
                    availableItems: vm.familyIllnessOptions,
                    selectedItems:
                        vm.familyHistory.map((e) => e.illness).toList(),
                    onDone: (list) {
                      vm.familyIllnessOptions
                        ..clear()
                        ..addAll(list);
                      vm.notifyListeners();
                    },
                  ),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// DETAILS
        ...vm.familyHistory.map(
          (item) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _KeyValueRow(
                title: item.illness,
                value: item.members.join(", "),
              ),
              GestureDetector(
                onTap: () => vm.openFamilyHistorySheet(context, item.illness),
                child: Text(
                  "Change",
                  style: AppTextStyle.bodyText2.copyWith(
                    color: context.colors.onSecondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),

        const Divider(height: 32),
      ],
    );
  }
}

class FamilyHistoryBottomSheet extends StatefulWidget {
  final String illness;
  final List<String> members;
  final List<String> selected;
  final ValueChanged<List<String>> onDone;

  const FamilyHistoryBottomSheet({
    super.key,
    required this.illness,
    required this.members,
    required this.selected,
    required this.onDone,
  });

  @override
  State<FamilyHistoryBottomSheet> createState() =>
      _FamilyHistoryBottomSheetState();
}

class _FamilyHistoryBottomSheetState extends State<FamilyHistoryBottomSheet> {
  late List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = [...widget.selected];
  }

  void toggle(String value) {
    setState(() {
      selected.contains(value) ? selected.remove(value) : selected.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              "Which family members has ${widget.illness} ?",
              style: AppTextStyle.title1Bold,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.members.map((m) {
                return _MedicalChip(
                  label: m,
                  selected: selected.contains(m),
                  onTap: () => toggle(m),
                  onRemove: () => toggle(m),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            _AddMoreChip(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => AddMoreBottomSheet(
                    availableItems: widget.members,
                    selectedItems: selected,
                    onDone: (list) {
                      setState(() {
                        selected = list;
                      });
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: "Done",
              onPressed: () {
                widget.onDone(selected);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LifestyleSection extends ViewModelWidget<MedicalHistoryViewModel> {
  const LifestyleSection({super.key});

  @override
  Widget build(BuildContext context, vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Lifestyle",
          onAddNotes: () => vm.openAddNotes(context, "Lifestyle"),
        ),
        const SizedBox(height: 6),
        Text(
          "Lifestyle habits",
          style: AppTextStyle.bodyText2SubText,
        ),
        const SizedBox(height: 12),

        /// CHIPS
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...vm.lifestyleOptions.map((e) {
              final selected = vm.lifestyle.any((l) => l.type == e);

              return _MedicalChip(
                label: e,
                selected: selected,
                onTap: () => vm.openLifestyleDetail(context, e),
                onRemove: selected ? () => vm.removeLifestyle(e) : null,
              );
            }),
            _AddMoreChip(onTap: () {}),
          ],
        ),

        const SizedBox(height: 16),

        /// DETAILS
        ...vm.lifestyle.map(
          (e) => LifestyleItemView(
            item: e,
            onChange: () => vm.openLifestyleDetail(context, e.type),
          ),
        ),

        const Divider(height: 32),
      ],
    );
  }
}

class LifestyleDetailBottomSheet extends StatefulWidget {
  final String title;
  final String unit;
  final LifestyleItem? existing;
  final ValueChanged<LifestyleItem> onSave;

  const LifestyleDetailBottomSheet({
    super.key,
    required this.title,
    required this.unit,
    this.existing,
    required this.onSave,
  });

  @override
  State<LifestyleDetailBottomSheet> createState() =>
      _LifestyleDetailBottomSheetState();
}

class LifestyleItemView extends StatelessWidget {
  final LifestyleItem item;
  final VoidCallback onChange;

  const LifestyleItemView({
    super.key,
    required this.item,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE → OPTION NAME ONLY
          Expanded(
            flex: 2,
            child: Text(
              item.type,
              style: AppTextStyle.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// RIGHT SIDE → DETAILS
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.status,
                  style: AppTextStyle.bodyText2Bold,
                ),
                const SizedBox(height: 4),
                Text(
                  "Since : ${item.since}",
                  style: AppTextStyle.bodyText2SubText,
                ),
                const SizedBox(height: 2),
                Text(
                  "Quantity : ${item.quantity} ${item.unit}",
                  style: AppTextStyle.bodyText2SubText,
                ),
                const SizedBox(height: 6),

                /// CHANGE
                GestureDetector(
                  onTap: onChange,
                  child: Text(
                    "Change",
                    style: AppTextStyle.bodyText2.copyWith(
                      color: context.colors.onSecondary,
                      decoration: TextDecoration.underline,
                    ),
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

class _LifestyleDetailBottomSheetState
    extends State<LifestyleDetailBottomSheet> {
  final statusOptions = ["Yes", "No", "Quit", "Occasional"];

  String? status;
  final sinceCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    status = widget.existing?.status;
    sinceCtrl.text = widget.existing?.since ?? "";
    qtyCtrl.text = widget.existing?.quantity ?? "";
  }

  @override
  Widget build(BuildContext context) {
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

            /// STATUS
            Wrap(
              spacing: 8,
              children: statusOptions.map((e) {
                return _YesNoChip(
                  label: e,
                  selected: status == e,
                  onTap: () => setState(() => status = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            /// SINCE
            TextField(
              controller: sinceCtrl,
              decoration: const InputDecoration(
                labelText: "Since",
                hintText: "Eg: 2000",
              ),
            ),

            const SizedBox(height: 16),

            /// QUANTITY
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity",
                hintText: widget.unit,
              ),
            ),

            const SizedBox(height: 24),

            /// DONE
            PrimaryButton(
              label: "Done",
              onPressed: () {
                widget.onSave(
                  LifestyleItem(
                    type: widget.title,
                    status: status ?? "",
                    since: sinceCtrl.text,
                    quantity: qtyCtrl.text,
                    unit: widget.unit,
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

class ProcedureSection extends ViewModelWidget<MedicalHistoryViewModel> {
  const ProcedureSection({super.key});

  @override
  Widget build(BuildContext context, vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Procedure",
          onAddNotes: () => vm.openAddNotes(context, "Procedure"),
        ),
        const SizedBox(height: 6),
        Text(
          "Have you undergone any procedures?",
          style: AppTextStyle.bodyText2SubText,
        ),
        const SizedBox(height: 12),

        /// YES / NO / DON'T KNOW
        Row(
          children: [
            _YesNoChip(
              label: "Yes",
              selected: vm.hasProcedure == true,
              onTap: () => vm.setHasProcedure(true, context),
            ),
            const SizedBox(width: 8),
            _YesNoChip(
              label: "No",
              selected: vm.hasProcedure == false,
              onTap: () => vm.setHasProcedure(false, context),
            ),
            const SizedBox(width: 8),
            _YesNoChip(
              label: "Don’t Know",
              selected: vm.hasProcedure == null,
              onTap: () {
                vm.hasProcedure = null;
                vm.procedures.clear();
                vm.notifyListeners();
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// PROCEDURE LIST
        if (vm.hasProcedure == true)
          ...vm.procedures.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(child: Text(p.name)),
                  Expanded(child: Text(p.duration)),
                ],
              ),
            ),
          ),

        if (vm.hasProcedure == true && vm.procedures.isNotEmpty)
          GestureDetector(
            onTap: () => vm.openProcedureList(context),
            child: Text(
              "Change",
              style: AppTextStyle.bodyText2.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

        const Divider(height: 32),
      ],
    );
  }
}

class ProcedureListSheet extends StatefulWidget {
  final List<String> options;
  final List<ProcedureItem> selected;
  final MedicalHistoryViewModel vm;

  const ProcedureListSheet({
    super.key,
    required this.options,
    required this.selected,
    required this.vm,
  });

  @override
  State<ProcedureListSheet> createState() => _ProcedureListSheetState();
}

class _ProcedureListSheetState extends State<ProcedureListSheet> {
  late List<String> localOptions;
  late List<String> selectedNames;

  @override
  void initState() {
    super.initState();
    localOptions = [...widget.options];
    selectedNames = widget.selected.map((e) => e.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedNames = widget.selected.map((e) => e.name).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Which procedures have you had?",
            style: AppTextStyle.title1Bold,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...widget.options.map((name) {
                final isSelected = selectedNames.contains(name);

                return _MedicalChip(
                  label: name,
                  selected: isSelected,
                  onTap: () {
                    if (!isSelected) {
                      Navigator.pop(context);
                      widget.vm.openProcedureDuration(context, name);
                    }
                  },
                  onRemove: isSelected
                      ? () {
                          setState(() {
                            selectedNames.remove(name);
                          });
                          widget.vm.procedures
                              .removeWhere((e) => e.name == name);
                          widget.vm.notifyListeners();
                        }
                      : null,
                );
              }),

              /// + ADD MORE
              _AddMoreChip(
                onTap: () async {
                  final result = await showModalBottomSheet<List<String>>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => AddMoreBottomSheet(
                      availableItems: localOptions,
                      selectedItems: localOptions,
                      onDone: (list) => Navigator.pop(context, list),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      localOptions = result;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: "Done",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class ProcedureDurationSheet extends StatefulWidget {
  final String procedureName;
  final ProcedureItem? existing;
  final ValueChanged<ProcedureItem> onSave;

  const ProcedureDurationSheet({
    super.key,
    required this.procedureName,
    this.existing,
    required this.onSave,
  });

  @override
  State<ProcedureDurationSheet> createState() => _ProcedureDurationSheetState();
}

class _ProcedureDurationSheetState extends State<ProcedureDurationSheet> {
  String? duration;

  final durations = const [
    "3–6 Months ago",
    "6–12 Months ago",
    "1–2 Years ago",
    "2–3 Years ago",
  ];

  @override
  void initState() {
    super.initState();
    duration = widget.existing?.duration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What is the duration (years) of ${widget.procedureName}?",
            style: AppTextStyle.title1Bold,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: durations.contains(duration) ? duration : null,
            hint: const Text("Select"),
            items: durations
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => duration = v),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: "Done",
            onPressed: () {
              widget.onSave(
                ProcedureItem(
                  name: widget.procedureName,
                  duration: duration ?? "--",
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class RiskFactorSection extends ViewModelWidget<MedicalHistoryViewModel> {
  const RiskFactorSection({super.key});

  @override
  Widget build(BuildContext context, vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Risk Factor",
          onAddNotes: () => vm.openAddNotes(context, "Risk Factor"),
        ),
        const SizedBox(height: 6),
        Text(
          "Any high risk factors?",
          style: AppTextStyle.bodyText2SubText,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...vm.riskFactors.map(
              (e) => _MedicalChip(
                label: e,
                selected: true,
                onTap: () {},
                onRemove: () {
                  vm.riskFactors.remove(e);
                  vm.notifyListeners();
                },
              ),
            ),
            _AddMoreChip(
              onTap: () => vm.openRiskFactorSheet(context),
            ),
          ],
        ),
        const Divider(height: 32),
      ],
    );
  }
}

class AddMoreBottomSheet extends StatefulWidget {
  final List<String> availableItems;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onDone;

  const AddMoreBottomSheet({
    super.key,
    required this.availableItems,
    required this.selectedItems,
    required this.onDone,
  });

  @override
  State<AddMoreBottomSheet> createState() => _AddMoreBottomSheetState();
}

class _AddMoreBottomSheetState extends State<AddMoreBottomSheet> {
  final TextEditingController searchCtrl = TextEditingController();
  late List<String> added;

  @override
  void initState() {
    super.initState();
    added = [...widget.selectedItems];
  }

  void addItem(String value) {
    if (!added.contains(value)) {
      setState(() => added.add(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.availableItems
        .where((e) => e.toLowerCase().contains(searchCtrl.text.toLowerCase()))
        .toList();

    final canCreate = searchCtrl.text.isNotEmpty &&
        !widget.availableItems.contains(searchCtrl.text);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add More", style: AppTextStyle.title1Bold),
            const SizedBox(height: 16),
            Text("Search", style: AppTextStyle.bodyText1),
            SizedBox(
              height: 2,
            ),

            /// SEARCH
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed:
                        canCreate ? () => addItem(searchCtrl.text) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D5AFE),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// MATCHED LIST
            if (filtered.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filtered.map((e) {
                  return _MedicalChip(
                    label: e,
                    selected: added.contains(e),
                    onTap: () => addItem(e),
                    onRemove: () {
                      setState(() => added.remove(e));
                    },
                  );
                }).toList(),
              ),

            const SizedBox(height: 16),

            /// ADDED
            if (added.isNotEmpty) ...[
              Text("Added", style: AppTextStyle.bodyText2Bold),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: added.map((e) {
                  return _MedicalChip(
                    label: e,
                    selected: true,
                    onTap: () {},
                    onRemove: () {
                      setState(() => added.remove(e));
                    },
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 24),

            /// DONE
            PrimaryButton(
                label: "Done",
                onPressed: () {
                  widget.onDone(added);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

class AddNotesBottomSheet extends StatefulWidget {
  final String title;
  final String initialText;
  final ValueChanged<String> onSave;

  const AddNotesBottomSheet({
    super.key,
    required this.title,
    required this.initialText,
    required this.onSave,
  });

  @override
  State<AddNotesBottomSheet> createState() => _AddNotesBottomSheetState();
}

class _AddNotesBottomSheetState extends State<AddNotesBottomSheet> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: AppTextStyle.title1Bold
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            Text('Notes',
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter notes",
                hintStyle: AppTextStyle.bodyText2SubText,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onPressed: () {
                  widget.onSave(controller.text);
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: AppTextStyle.buttonLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
