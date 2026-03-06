import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_symptoms_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpSymptomsView extends ConsumerWidget {
  final String consultationId;

  const OpSymptomsView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opSymptomsControllerProvider(consultationId));
    final controller = ref.watch(opSymptomsControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Symptoms'),
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
          onPressed: controller.canSave ? controller.onSaveSymptoms : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Symptoms', style: TextStyle(fontWeight: FontWeight.w600)),
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
                hintText: 'Search symptoms',
                onChanged: (_) => controller.onSearchChanged(),
              ),

              SizedBox(height: 16.h),

              /// SELECTED SYMPTOMS
              if (controller.selectedSymptoms.isNotEmpty) ...[
                Text('Selected Symptoms', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: controller.selectedSymptoms.map((symptom) {
                    return _SymptomChip(
                      label: symptom.name,
                      selected: true,
                      showWarning: !symptom.isComplete,
                      onTap: () => controller.openSymptomDetail(context, symptom.name, existing: symptom),
                      onRemove: () => controller.removeSymptom(symptom),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24.h),
              ],

              /// AVAILABLE SYMPTOMS
              Text('Symptoms', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      ...controller.filteredSymptoms.map(
                        (symptom) => _SymptomChip(
                          label: symptom,
                          onTap: () => controller.toggleSymptom(context, symptom),
                        ),
                      ),
                      if (controller.canCreate)
                        _SymptomChip(
                          label: '+ Create "${controller.searchText}"',
                          onTap: () => controller.createSymptom(context),
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

class _SymptomChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool showWarning;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const _SymptomChip({
    required this.label,
    this.selected = false,
    this.showWarning = false,
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
            if (showWarning) ...[
              Icon(Icons.warning_amber_rounded, size: 14, color: Colors.orange),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: AppTextStyle.bodyText2.copyWith(
                color: selected ? AppColor.primary : AppColor.textOnPrimary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
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

class SymptomDetailsBottomSheet extends StatefulWidget {
  final SymptomItem symptom;
  final ValueChanged<SymptomItem> onSave;

  const SymptomDetailsBottomSheet({
    super.key,
    required this.symptom,
    required this.onSave,
  });

  @override
  State<SymptomDetailsBottomSheet> createState() => _SymptomDetailsBottomSheetState();
}

class _SymptomDetailsBottomSheetState extends State<SymptomDetailsBottomSheet> {
  final sinceOptions = ['1 day', '2 days', '3 days', '1 week', '2 weeks', '1 month'];
  final severityOptions = ['Mild', 'Moderate', 'Severe'];

  bool get canSave => widget.symptom.since != null && widget.symptom.severity != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DRAG HANDLE
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// TITLE
            Text(
              widget.symptom.name,
              style: AppTextStyle.bodyText1.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20.h),

            /// SINCE DROPDOWN
            Text('Since', style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 6.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.containerOutline),
              ),
              child: DropdownButtonFormField<String>(
                value: widget.symptom.since,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  border: InputBorder.none,
                ),
                hint: Text('Select duration'),
                items: sinceOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => widget.symptom.since = v),
              ),
            ),

            SizedBox(height: 16.h),

            /// SEVERITY
            Text('Severity', style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              children: severityOptions.map((e) {
                final selected = widget.symptom.severity == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: AppColor.primary.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: selected ? AppColor.primary : AppColor.textOnPrimary,
                  ),
                  onSelected: (_) => setState(() => widget.symptom.severity = e),
                );
              }).toList(),
            ),

            SizedBox(height: 24.h),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canSave
                    ? () {
                        widget.onSave(widget.symptom);
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.labletext,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
                ),
                child: Text('Save', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
