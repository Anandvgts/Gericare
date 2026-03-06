import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_medical_history_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpMedicalHistoryView extends ConsumerWidget {
  final String patientId;

  const OpMedicalHistoryView({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opMedicalHistoryControllerProvider(patientId));
    final controller = ref.watch(opMedicalHistoryControllerProvider(patientId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Medical History'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton(
          onPressed: controller.onSaveMedicalHistory,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Medical History', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            /// PAST MEDICAL HISTORY
            _HistorySection(
            title: 'Past Medical History',
            items: controller.pastMedicalHistory,
            allItems: controller.allPastMedicalConditions,
            onAdd: (item) => controller.addPastMedicalHistory(item),
            onRemove: (item) => controller.removePastMedicalHistory(item),
          ),

          SizedBox(height: 16.h),

          /// SURGICAL HISTORY
          _HistorySection(
            title: 'Surgical History',
            items: controller.surgicalHistory,
            allItems: controller.allSurgeries,
            onAdd: (item) => controller.addSurgicalHistory(item),
            onRemove: (item) => controller.removeSurgicalHistory(item),
          ),

          SizedBox(height: 16.h),

          /// FAMILY HISTORY
          _HistorySection(
            title: 'Family History',
            items: controller.familyHistory,
            allItems: controller.allFamilyConditions,
            onAdd: (item) => controller.addFamilyHistory(item),
            onRemove: (item) => controller.removeFamilyHistory(item),
          ),

          SizedBox(height: 16.h),

          /// ALLERGIES
          _HistorySection(
            title: 'Allergies',
            items: controller.allergies,
            allItems: controller.allAllergies,
            onAdd: (item) => controller.addAllergy(item),
            onRemove: (item) => controller.removeAllergy(item),
          ),

          SizedBox(height: 16.h),

          /// SOCIAL HISTORY
          _SocialHistorySection(controller: controller),

          SizedBox(height: 16.h),

          /// ADDITIONAL NOTES
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.containerOutline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Additional Notes', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 12.h),
                TextField(
                  controller: controller.notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Add any additional notes...',
                    hintStyle: AppTextStyle.bodyText2SubText,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColor.containerOutline),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  final String title;
  final List<String> items;
  final List<String> allItems;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  const _HistorySection({
    required this.title,
    required this.items,
    required this.allItems,
    required this.onAdd,
    required this.onRemove,
  });

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
              Text(title, style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
              IconButton(
                icon: Icon(Icons.add_circle_outline, color: AppColor.primary),
                onPressed: () => _showAddDialog(context),
              ),
            ],
          ),
          if (items.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text('No items added', style: AppTextStyle.caption.copyWith(color: AppColor.secondaryText)),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: items.map((item) {
                return Chip(
                  label: Text(item, style: AppTextStyle.bodyText2.copyWith(fontSize: 12)),
                  deleteIcon: Icon(Icons.close, size: 16),
                  onDeleted: () => onRemove(item),
                  backgroundColor: AppColor.primary.withOpacity(0.1),
                  deleteIconColor: AppColor.primary,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddItemSheet(
        title: 'Add $title',
        items: allItems.where((i) => !items.contains(i)).toList(),
        onAdd: onAdd,
      ),
    );
  }
}

class _AddItemSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final ValueChanged<String> onAdd;

  const _AddItemSheet({required this.title, required this.items, required this.onAdd});

  @override
  State<_AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<_AddItemSheet> {
  final searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _filter(String query) {
    setState(() {
      filteredItems = widget.items.where((i) => i.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4.r)))),
          SizedBox(height: 16.h),
          Text(widget.title, style: AppTextStyle.bodyText1.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          TextField(
            controller: searchController,
            onChanged: _filter,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text(item),
                  trailing: Icon(Icons.add, color: AppColor.primary),
                  onTap: () {
                    widget.onAdd(item);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialHistorySection extends StatelessWidget {
  final OpMedicalHistoryController controller;

  const _SocialHistorySection({required this.controller});

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
          Text('Social History', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),

          _SocialHistoryRow(
            label: 'Smoking',
            value: controller.smokingStatus,
            options: ['Never', 'Former', 'Current'],
            onChanged: controller.setSmokingStatus,
          ),
          SizedBox(height: 12.h),

          _SocialHistoryRow(
            label: 'Alcohol',
            value: controller.alcoholStatus,
            options: ['Never', 'Occasional', 'Regular'],
            onChanged: controller.setAlcoholStatus,
          ),
          SizedBox(height: 12.h),

          _SocialHistoryRow(
            label: 'Exercise',
            value: controller.exerciseStatus,
            options: ['None', 'Occasional', 'Regular'],
            onChanged: controller.setExerciseStatus,
          ),
        ],
      ),
    );
  }
}

class _SocialHistoryRow extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _SocialHistoryRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Text(label, style: AppTextStyle.bodyText2),
        ),
        Expanded(
          child: Wrap(
            spacing: 8.w,
            children: options.map((option) {
              final selected = value == option;
              return ChoiceChip(
                label: Text(option, style: TextStyle(fontSize: 12)),
                selected: selected,
                selectedColor: AppColor.primary.withOpacity(0.1),
                labelStyle: TextStyle(
                  color: selected ? AppColor.primary : AppColor.textOnPrimary,
                ),
                onSelected: (_) => onChanged(option),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
