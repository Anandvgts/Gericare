import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_diagnosis_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpDiagnosisView extends ConsumerWidget {
  final String consultationId;

  const OpDiagnosisView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opDiagnosisControllerProvider(consultationId));
    final controller = ref.watch(opDiagnosisControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Diagnosis'),
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
          onPressed: controller.selectedDiagnosis.isNotEmpty ? controller.onSaveDiagnosis : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Diagnosis', style: TextStyle(fontWeight: FontWeight.w600)),
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
              hintText: 'Search diagnosis',
              onChanged: (_) => controller.onSearchChanged(),
            ),

            SizedBox(height: 16.h),

            /// SELECTED DIAGNOSIS
            if (controller.selectedDiagnosis.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Selected Diagnosis', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
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
                children: controller.selectedDiagnosis.map((diagnosis) {
                  return _DiagnosisChip(
                    label: diagnosis.name,
                    selected: true,
                    onTap: () => controller.openDiagnosisDetail(context, diagnosis.name, existing: diagnosis),
                    onRemove: () => controller.removeDiagnosis(diagnosis),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
            ],

            /// AVAILABLE DIAGNOSIS
            Text('Diagnosis', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ...controller.filteredDiagnosis.map(
                      (diagnosis) => _DiagnosisChip(
                        label: diagnosis,
                        onTap: () => controller.toggleDiagnosis(context, diagnosis),
                      ),
                    ),
                    if (controller.canCreate)
                      _DiagnosisChip(
                        label: '+ Create "${controller.searchText}"',
                        onTap: () => controller.createDiagnosis(context),
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

class _DiagnosisChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const _DiagnosisChip({
    required this.label,
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

class DiagnosisDetailsBottomSheet extends StatefulWidget {
  final DiagnosisItem diagnosis;
  final ValueChanged<DiagnosisItem> onSave;

  const DiagnosisDetailsBottomSheet({
    super.key,
    required this.diagnosis,
    required this.onSave,
  });

  @override
  State<DiagnosisDetailsBottomSheet> createState() => _DiagnosisDetailsBottomSheetState();
}

class _DiagnosisDetailsBottomSheetState extends State<DiagnosisDetailsBottomSheet> {
  final sinceOptions = ['0-3 Months', '3-6 Months', '6-12 Months', '1-2 Years', '2+ Years'];
  final treatmentOptions = ['On Treatment', 'Not On Treatment', 'Medicine On and Off'];

  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController(text: widget.diagnosis.location);
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

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
              widget.diagnosis.name,
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
                value: widget.diagnosis.since,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  border: InputBorder.none,
                ),
                hint: Text('Select duration'),
                items: sinceOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => widget.diagnosis.since = v),
              ),
            ),

            SizedBox(height: 16.h),

            /// LOCATION
            Text('Location', style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 6.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.containerOutline),
              ),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Enter location',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  border: InputBorder.none,
                ),
                onChanged: (v) => widget.diagnosis.location = v,
              ),
            ),

            SizedBox(height: 16.h),

            /// TREATMENT STATUS
            Text('Treatment Status', style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: treatmentOptions.map((e) {
                final selected = widget.diagnosis.treatmentStatus == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: AppColor.primary.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: selected ? AppColor.primary : AppColor.textOnPrimary,
                    fontSize: 12,
                  ),
                  onSelected: (_) => setState(() => widget.diagnosis.treatmentStatus = e),
                );
              }).toList(),
            ),

            SizedBox(height: 24.h),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(widget.diagnosis);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.labletext,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
                ),
                child: Text('Continue', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
