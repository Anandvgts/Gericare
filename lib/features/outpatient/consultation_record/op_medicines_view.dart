import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_medicines_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpMedicinesView extends ConsumerWidget {
  final String consultationId;

  const OpMedicinesView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opMedicinesControllerProvider(consultationId));
    final controller = ref.watch(opMedicinesControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Medicines'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.selectedMedicines.isNotEmpty ? controller.onSaveMedicines : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Medicines', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SEARCH BAR
              _SearchField(
              controller: controller.searchController,
              hintText: 'Search medicines',
              onChanged: (_) => controller.onSearchChanged(),
            ),

            SizedBox(height: 16.h),

            /// SELECTED MEDICINES
            if (controller.selectedMedicines.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Selected Medicines', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () {},
                    child: Text('Past Medicines', style: TextStyle(color: AppColor.primary, fontSize: 12)),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.selectedMedicines.map((medicine) {
                  return _MedicineChip(
                    label: medicine.name,
                    subtitle: medicine.dosageSummary,
                    selected: true,
                    onRemove: () => controller.removeMedicine(medicine),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
            ],

            /// AVAILABLE MEDICINES
            Text('Medicines', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ...controller.filteredMedicines.map(
                      (medicine) => _MedicineChip(
                        label: medicine,
                        onTap: () => controller.openMedicineDosage(context, medicine),
                      ),
                    ),
                    if (controller.canCreate)
                      _MedicineChip(
                        label: '+ Create "${controller.searchText}"',
                        onTap: () => controller.createMedicine(context),
                      ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const _SearchField({
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.bodyText2SubText,
          prefixIcon: Icon(Icons.search, color: AppColor.secondaryText),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }
}

class _MedicineChip extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const _MedicineChip({
    required this.label,
    this.subtitle,
    this.selected = false,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? AppColor.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? AppColor.primary : AppColor.containerOutline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTextStyle.bodyText2.copyWith(
                    color: selected ? AppColor.primary : AppColor.textOnPrimary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty)
                  Text(
                    subtitle!,
                    style: AppTextStyle.caption.copyWith(
                      color: AppColor.secondaryText,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
            if (onRemove != null) ...[
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.close, size: 16, color: AppColor.secondaryText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Medicine Dosage View
class OpMedicineDosageView extends ConsumerWidget {
  final String medicineName;

  const OpMedicineDosageView({super.key, required this.medicineName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(opMedicineDosageControllerProvider.notifier);
    final state = ref.watch(opMedicineDosageControllerProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBarWidget(title: medicineName),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, controller.getMedicineData()),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Add Medicine', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _QuantitySection(controller: controller),
          SizedBox(height: 24.h),
          _TimingSection(controller: controller),
          SizedBox(height: 24.h),
          _DurationSection(controller: controller),
          SizedBox(height: 24.h),
          _NotesSection(controller: controller),
        ],
      ),
    );
  }
}

class _QuantitySection extends StatelessWidget {
  final OpMedicineDosageController controller;
  const _QuantitySection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quantity', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),

          /// TYPE DROPDOWN
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: DropdownButtonFormField<MedicineType>(
              value: controller.type,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                border: InputBorder.none,
              ),
              items: const [
                DropdownMenuItem(value: MedicineType.tablet, child: Text('Tablets')),
                DropdownMenuItem(value: MedicineType.syrup, child: Text('Syrup')),
                DropdownMenuItem(value: MedicineType.injection, child: Text('Injection')),
                DropdownMenuItem(value: MedicineType.capsule, child: Text('Capsule')),
              ],
              onChanged: (v) => controller.setType(v!),
            ),
          ),

          SizedBox(height: 12.h),

          /// QUANTITY CHIPS
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: controller.quantityOptions.map((q) {
              final selected = controller.quantity == q;
              return _SelectableChip(
                label: controller.formatQuantity(q),
                selected: selected,
                onTap: () => controller.setQuantity(q),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TimingSection extends StatelessWidget {
  final OpMedicineDosageController controller;
  const _TimingSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Timing', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: controller.toggleTimingMode,
                child: Text('Switch', style: TextStyle(color: AppColor.primary, fontSize: 12)),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          if (controller.timingMode == TimingMode.frequency) ...[
            /// FREQUENCY CHIPS
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: ['Once', 'Twice', 'Thrice', '4 times', '6h', '8h', '12h'].map((f) {
                final selected = controller.frequency == f;
                return _SelectableChip(
                  label: f,
                  selected: selected,
                  onTap: () => controller.setFrequency(f),
                );
              }).toList(),
            ),

            SizedBox(height: 16.h),

            Text('Intake', style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: ['Before Food', 'After Food', 'Empty Stomach', 'Bed Time'].map((i) {
                final selected = controller.intake == i;
                return _SelectableChip(
                  label: i,
                  selected: selected,
                  onTap: () => controller.setIntake(i),
                );
              }).toList(),
            ),
          ] else ...[
            /// DAY PART MODE
            _DayPartRow(
              label: 'Morning',
              quantity: controller.morningQty,
              intake: controller.morningIntake,
              onMinus: () => controller.updateDayQty('morning', -1),
              onPlus: () => controller.updateDayQty('morning', 1),
            ),
            SizedBox(height: 12.h),
            _DayPartRow(
              label: 'Noon',
              quantity: controller.noonQty,
              intake: controller.noonIntake,
              onMinus: () => controller.updateDayQty('noon', -1),
              onPlus: () => controller.updateDayQty('noon', 1),
            ),
            SizedBox(height: 12.h),
            _DayPartRow(
              label: 'Night',
              quantity: controller.nightQty,
              intake: controller.nightIntake,
              onMinus: () => controller.updateDayQty('night', -1),
              onPlus: () => controller.updateDayQty('night', 1),
            ),
          ],
        ],
      ),
    );
  }
}

class _DayPartRow extends StatelessWidget {
  final String label;
  final double quantity;
  final String intake;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _DayPartRow({
    required this.label,
    required this.quantity,
    required this.intake,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Text(label, style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
          ),
          Text(intake, style: AppTextStyle.caption.copyWith(color: AppColor.secondaryText)),
          const Spacer(),
          _QtyButton(icon: Icons.remove, onTap: onMinus),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(quantity.toString(), style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w600)),
          ),
          _QtyButton(icon: Icons.add, onTap: onPlus),
        ],
      ),
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
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.containerOutline),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}

class _DurationSection extends StatelessWidget {
  final OpMedicineDosageController controller;
  const _DurationSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Duration', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ['1 Day', '3 Days', '1 Week', '2 Weeks', '1 Month', 'Till Required', 'SOS'].map((d) {
              final selected = controller.duration == d;
              return _SelectableChip(
                label: d,
                selected: selected,
                onTap: () => controller.setDuration(d),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _NotesSection extends StatelessWidget {
  final OpMedicineDosageController controller;
  const _NotesSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notes', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),
          TextField(
            controller: controller.notesController,
            decoration: InputDecoration(
              hintText: 'Enter notes',
              hintStyle: AppTextStyle.bodyText2SubText,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColor.containerOutline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColor.containerOutline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? AppColor.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? AppColor.primary : AppColor.containerOutline,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.bodyText2.copyWith(
            color: selected ? AppColor.primary : AppColor.textOnPrimary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
