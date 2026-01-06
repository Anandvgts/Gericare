import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/medicine/medicine_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/app_chips.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:gericare_doctor/ui/widgets/search_bar_widget.dart';
import 'package:stacked/stacked.dart';

class MedicinesView extends StatelessWidget {
  const MedicinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MedicinesViewModel>.reactive(
      viewModelBuilder: () => MedicinesViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: const AppBarWidget(
            showBack: true,
            title: "Medicines",
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Save Medicines",
              onPressed: () {},
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// SEARCH
                SearchBarField(
                  controller: vm.searchCtrl,
                  hintText: "Search medicines",
                  onChanged: (_) => vm.notifyListeners(),
                ),

                const SizedBox(height: 16),

                /// SELECTED
                if (vm.selectedMedicines.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Selected Medicines", style: AppTextStyle.bodyText1),
                      Text(
                        "Past Medicines",
                        style: AppTextStyle.bodyText2
                            .copyWith(color: context.colors.onSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: vm.selectedMedicines
                        .map(
                          (e) => AppChip(
                            label: e.name,
                            selected: true,

                            // showClose: true,
                            // subtitle: e.dosageSummary.isEmpty
                            //     ? null
                            //     : e.dosageSummary,
                            onRemove: () => vm.removeMedicine(e.name),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],

                /// AVAILABLE
                Text("Medicines", style: AppTextStyle.bodyText1),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...vm.filteredMedicines.map(
                      (e) => AppChip(
                        label: e,
                        selected: false,
                        onTap: () => vm.openMedicineDetail(context, e),
                      ),
                    ),
                    if (vm.canCreate)
                      AppChip(
                        label: '+ Create "${vm.searchText}"',
                        selected: false,
                        onTap: () => vm.createMedicine(context),
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

class MedicineDosageView extends StatelessWidget {
  final String medicineName;

  const MedicineDosageView({super.key, required this.medicineName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MedicineDosageViewModel>.reactive(
      viewModelBuilder: () => MedicineDosageViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarWidget(
            showBack: true,
            title: medicineName,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Add Medicine",
              onPressed: () {
                Navigator.pop(context, {
                  "type": vm.type,
                  "quantity": vm.quantity,
                  "timing": vm.timingMode,
                  "duration": vm.duration,
                  "notes": vm.notes,
                });
              },
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _QuantitySection(vm),
              const SizedBox(height: 24),
              _TimingSection(vm),
              const SizedBox(height: 24),
              _DurationSection(vm),
              const SizedBox(height: 24),
              _NotesSection(vm),
            ],
          ),
        );
      },
    );
  }
}

class _QuantitySection extends StatelessWidget {
  final MedicineDosageViewModel vm;
  const _QuantitySection(this.vm);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Quantity", style: AppTextStyle.bodyText2Bold),
      const SizedBox(height: 8),

      /// TYPE DROPDOWN
      DropdownButtonFormField<MedicineType>(
        decoration: InputDecoration(
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
        value: vm.type,
        items: const [
          DropdownMenuItem(
            value: MedicineType.tablet,
            child: Text("Tablets"),
          ),
          DropdownMenuItem(
            value: MedicineType.syrup,
            child: Text("Syrup"),
          ),
        ],
        onChanged: (v) => vm.setType(v!),
      ),

      const SizedBox(height: 12),

      /// QUANTITY CHIPS
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: vm.quantityOptions.map((q) {
          return AppChip(
            brColor: context.colors.onSecondary,
            bgColor: context.colors.onSecondary.withOpacity(0.1),
            label: Helper.formatQuantity(
              q,
              isTablet: vm.type == MedicineType.tablet,
            ),
            selected: vm.quantity == q,
            onTap: () => vm.setQuantity(q),
          );
        }).toList(),
      ),
    ]);
  }
}

class _TimingSection extends StatelessWidget {
  final MedicineDosageViewModel vm;
  const _TimingSection(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Timing", style: AppTextStyle.bodyText2Bold),
          GestureDetector(
            onTap: vm.toggleTimingMode,
            child: Text("Switch",
                style: AppTextStyle.bodyText2.copyWith(
                  color: context.colors.onSecondary,
                )),
          ),
        ],
      ),
      const SizedBox(height: 12),
      vm.timingMode == TimingMode.frequency
          ? _FrequencyMode(vm)
          : _DayPartMode(vm),
    ]);
  }
}

class _FrequencyMode extends StatelessWidget {
  final MedicineDosageViewModel vm;
  const _FrequencyMode(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colors.outline.withOpacity(0.6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colors.primary,
                width: 1.2,
              ),
            )),
        value: vm.frequencyUnit,
        items: ["Hour", "Day", "Week", "Month"]
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => vm.frequencyUnit = v!,
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          "4h",
          "6h",
          "8h",
          "Once",
          "Twice",
          "Thrice",
          "4 times",
          "5 times"
        ].map((e) {
          return AppChip(
            brColor: context.colors.onSecondary,
            bgColor: context.colors.onSecondary.withOpacity(0.1),
            label: e,
            selected: vm.frequencyValue == e,
            onTap: () {
              vm.frequencyValue = e;
              vm.notifyListeners();
            },
          );
        }).toList(),
      ),
      const SizedBox(height: 16),
      Text("Intake", style: AppTextStyle.bodyText2Bold),
      Wrap(
        spacing: 8,
        runSpacing: 6,
        children:
            ["Before Food", "After Food", "Empty Stomach", "Bed Time"].map((e) {
          return AppChip(
            brColor: context.colors.onSecondary,
            bgColor: context.colors.onSecondary.withOpacity(0.1),
            label: e,
            selected: vm.intake == e,
            onTap: () => vm.setIntake(e),
          );
        }).toList(),
      ),
    ]);
  }
}

class _DayPartMode extends StatelessWidget {
  final MedicineDosageViewModel vm;
  _DayPartMode(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        DayPartRow(
          label: "Morning",
          intake: vm.morningIntake,
          quantity: vm.morningQty,
          isTablet: vm.type == MedicineType.tablet,
          onMinus: () => vm.updateDayQty("morning", -1),
          onPlus: () => vm.updateDayQty("morning", 1),
          onIntakeTap: () {},
        ),
        DayPartRow(
          label: "Noon",
          intake: vm.morningIntake,
          quantity: vm.noonQty,
          isTablet: vm.type == MedicineType.tablet,
          onMinus: () => vm.updateDayQty("noon", -1),
          onPlus: () => vm.updateDayQty("noon", 1),
          onIntakeTap: () {},
        ),
        DayPartRow(
          label: "Night",
          intake: vm.morningIntake,
          quantity: vm.nightQty,
          isTablet: vm.type == MedicineType.tablet,
          onMinus: () => vm.updateDayQty("night", -1),
          onPlus: () => vm.updateDayQty("night", 1),
          onIntakeTap: () {},
        ),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class DayPartRow extends StatelessWidget {
  final String label;
  final String intake;
  final VoidCallback onIntakeTap;
  final double quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final bool isTablet;

  const DayPartRow({
    super.key,
    required this.label,
    required this.intake,
    required this.onIntakeTap,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyle.bodyText2Bold
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              /// Intake dropdown
              GestureDetector(
                onTap: onIntakeTap,
                child: Row(
                  children: [
                    Text(
                      intake,
                      style: AppTextStyle.bodyText2.copyWith(
                          color: context.colors.onSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: context.colors.onSecondary,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Minus
              _QtyButton(icon: Icons.remove, onTap: onMinus),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  Helper.formatQuantity(quantity, isTablet: isTablet),
                  style: AppTextStyle.bodyText2Bold,
                ),
              ),

              /// Plus
              _QtyButton(icon: Icons.add, onTap: onPlus),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _DurationSection extends StatelessWidget {
  final MedicineDosageViewModel vm;
  const _DurationSection(this.vm);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Duration", style: AppTextStyle.bodyText2Bold),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          "1 Day",
          "3 Days",
          "1 Week",
          "1 Month",
          "Till Required",
          "SOS"
        ].map((e) {
          return AppChip(
            brColor: context.colors.onSecondary,
            bgColor: context.colors.onSecondary.withOpacity(0.1),
            label: e,
            selected: vm.duration == e,
            onTap: () => vm.setDuration(e),
          );
        }).toList(),
      ),
    ]);
  }
}

class _NotesSection extends StatelessWidget {
  final MedicineDosageViewModel vm;
  const _NotesSection(this.vm);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Notes", style: AppTextStyle.bodyText1),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
            hintText: "Enter",
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
        onChanged: (v) => vm.notes = v,
      ),
    ]);
  }
}
