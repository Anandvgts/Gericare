import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_instructions_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpInstructionsView extends ConsumerWidget {
  final String consultationId;

  const OpInstructionsView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opInstructionsControllerProvider(consultationId));
    final controller = ref.watch(opInstructionsControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Instructions'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton(
          onPressed: controller.selectedInstructions.isNotEmpty ? controller.onSaveInstructions : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Instructions', style: TextStyle(fontWeight: FontWeight.w600)),
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
              Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.containerOutline),
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: (_) => controller.onSearchChanged(),
                decoration: InputDecoration(
                  hintText: 'Search instructions',
                  hintStyle: AppTextStyle.bodyText2SubText,
                  prefixIcon: Icon(Icons.search, color: AppColor.secondaryText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// SELECTED INSTRUCTIONS
            if (controller.selectedInstructions.isNotEmpty) ...[
              Text('Selected Instructions', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.selectedInstructions.map((instruction) {
                  return _InstructionChip(
                    label: instruction,
                    selected: true,
                    onRemove: () => controller.removeInstruction(instruction),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
            ],

            /// AVAILABLE INSTRUCTIONS
            Text('Instructions', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ...controller.filteredInstructions.map(
                      (instruction) => _InstructionChip(
                        label: instruction,
                        onTap: () => controller.toggleInstruction(instruction),
                      ),
                    ),
                    if (controller.canCreate)
                      _InstructionChip(
                        label: '+ Create "${controller.searchText}"',
                        onTap: () => controller.createInstruction(),
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// CUSTOM INSTRUCTION INPUT
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.containerOutline),
              ),
              child: TextField(
                controller: controller.customInstructionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add custom instruction...',
                  hintStyle: AppTextStyle.bodyText2SubText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add_circle, color: AppColor.primary),
                    onPressed: controller.addCustomInstruction,
                  ),
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

class _InstructionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const _InstructionChip({required this.label, this.selected = false, this.onTap, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? AppColor.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: selected ? AppColor.primary : AppColor.containerOutline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                style: AppTextStyle.bodyText2.copyWith(
                  color: selected ? AppColor.primary : AppColor.textOnPrimary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (onRemove != null) ...[
              SizedBox(width: 4.w),
              GestureDetector(onTap: onRemove, child: Icon(Icons.close, size: 16, color: AppColor.secondaryText)),
            ],
          ],
        ),
      ),
    );
  }
}
