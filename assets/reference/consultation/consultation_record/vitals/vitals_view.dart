import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/vitals/vitals_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class VitalsView extends StatelessWidget {
  const VitalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VitalsViewModel>.reactive(
      viewModelBuilder: () => VitalsViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: const AppBarWidget(
            showBack: true,
            title: "Vitals",
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Submit",
              onPressed: () {},
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyle.bodyText2SubText,
                  children: [
                    TextSpan(
                      text: '${vm.selectedCount} ',
                      style: AppTextStyle.bodyText2Bold,
                    ),
                    const TextSpan(text: 'Selected'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...vm.vitals.map(
                    (item) => VitalRow(
                      item: item,
                      onTap: () => vm.toggleVital(context, item),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class VitalRow extends StatelessWidget {
  final VitalItem item;
  final VoidCallback onTap;

  const VitalRow({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
                  item.icon,
                  width: 22,
                  height: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(item.title, style: AppTextStyle.bodyText1),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: item.selected
                      ? context.colors.primary
                      : context.colors.outline,
                ),
                color:
                    item.selected ? context.colors.primary : Colors.transparent,
              ),
              child: item.selected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class TemperatureSheet extends StatefulWidget {
  const TemperatureSheet({super.key});

  @override
  State<TemperatureSheet> createState() => _TemperatureSheetState();
}

class _TemperatureSheetState extends State<TemperatureSheet> {
  String? duration;
  String? frequency;
  String notes = '';

  final List<DurationOption> durationOptions = [
    DurationOption("1 Day", "1d"),
    DurationOption("2 Days", "2d"),
    DurationOption("3 Days", "3d"),
    DurationOption("4 Days", "4d"),
    DurationOption("5 Days", "5d"),
    DurationOption("1 Week", "1w"),
    DurationOption("2 Weeks", "2w"),
    DurationOption("3 Weeks", "3w"),
    DurationOption("1 Month", "1m"),
  ];

  final frequencyOptions = [
    "4h",
    "6h",
    "8h",
    "12h",
    "48h",
    "Once",
    "Twice",
    "Thrice",
    "4 times"
  ];

  String? durationValue; // stores "1d", "3w", etc

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
            Text("Temperature",
                style: AppTextStyle.title1Bold
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),

            /// -------- DURATION --------
            Text("Duration",
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              
              value: duration,
              hint: const Text("Select Duration"),
              items: durationOptions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.value,
                      child: Text(e.label),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => duration = v),
              decoration: _inputDecoration(colors),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: durationOptions.map((e) {
                return _ChoiceChip(
                  label: e.value, // shows 1d, 3w etc
                  selected: durationValue == e.value,
                  onTap: () => setState(() => durationValue = e.value),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// -------- FREQUENCY --------
            Text("Frequency",
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              value: frequency,
              hint: const Text("Select Frequency"),
              items: frequencyOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => frequency = v),
              decoration: _inputDecoration(colors),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: frequencyOptions.map((e) {
                return _ChoiceChip(
                  label: e,
                  selected: frequency == e,
                  onTap: () => setState(() => frequency = e),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            /// -------- NOTES --------
            Text("Notes",
                style: AppTextStyle.bodyText2Bold
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),

            TextField(
              maxLines: 3,
              decoration: _inputDecoration(colors).copyWith(
                hintText: "Enter notes",
              ),
              onChanged: (v) => notes = v,
            ),

            const SizedBox(height: 24),

            /// SAVE
            PrimaryButton(
              label: "Save",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(ColorScheme colors) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.outline.withOpacity(0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.primary),
      ),
    );
  }
}

Widget _ChoiceChip({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? Colors.blue : Colors.grey.shade400,
        ),
        color: selected ? Colors.blue.withOpacity(0.08) : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.blue : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

class DurationOption {
  final String label; // shown in dropdown
  final String value; // internal value

  const DurationOption(this.label, this.value);
}
