import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_investigations_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpInvestigationsView extends ConsumerWidget {
  final String consultationId;

  const OpInvestigationsView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opInvestigationsControllerProvider(consultationId));
    final controller = ref.watch(opInvestigationsControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Investigations'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton(
          onPressed: controller.selectedInvestigations.isNotEmpty ? controller.onSaveInvestigations : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Investigations', style: TextStyle(fontWeight: FontWeight.w600)),
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
                  hintText: 'Search investigations',
                  hintStyle: AppTextStyle.bodyText2SubText,
                  prefixIcon: Icon(Icons.search, color: AppColor.secondaryText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// SELECTED INVESTIGATIONS
            if (controller.selectedInvestigations.isNotEmpty) ...[
              Text('Selected Investigations', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: controller.selectedInvestigations.map((investigation) {
                  return _InvestigationChip(
                    label: investigation.name,
                    subtitle: investigation.urgency,
                    selected: true,
                    onTap: () => controller.openInvestigationDetail(context, investigation.name, existing: investigation),
                    onRemove: () => controller.removeInvestigation(investigation),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
            ],

            /// CATEGORIES
            Text('Categories', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            SizedBox(
              height: 40.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: controller.categories.map((category) {
                  final selected = controller.selectedCategory == category;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      selectedColor: AppColor.primary.withOpacity(0.1),
                      onSelected: (_) => controller.selectCategory(category),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 16.h),

            /// AVAILABLE INVESTIGATIONS
            Text('Investigations', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ...controller.filteredInvestigations.map(
                      (investigation) => _InvestigationChip(
                        label: investigation,
                        onTap: () => controller.toggleInvestigation(context, investigation),
                      ),
                    ),
                    if (controller.canCreate)
                      _InvestigationChip(
                        label: '+ Create "${controller.searchText}"',
                        onTap: () => controller.createInvestigation(context),
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

class _InvestigationChip extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const _InvestigationChip({required this.label, this.subtitle, this.selected = false, this.onTap, this.onRemove});

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: AppTextStyle.bodyText2.copyWith(
                  color: selected ? AppColor.primary : AppColor.textOnPrimary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                )),
                if (subtitle != null)
                  Text(subtitle!, style: AppTextStyle.caption.copyWith(color: AppColor.secondaryText, fontSize: 10)),
              ],
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

class InvestigationDetailsBottomSheet extends StatefulWidget {
  final InvestigationItem investigation;
  final ValueChanged<InvestigationItem> onSave;

  const InvestigationDetailsBottomSheet({super.key, required this.investigation, required this.onSave});

  @override
  State<InvestigationDetailsBottomSheet> createState() => _InvestigationDetailsBottomSheetState();
}

class _InvestigationDetailsBottomSheetState extends State<InvestigationDetailsBottomSheet> {
  final urgencyOptions = ['Routine', 'Urgent', 'STAT'];
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(text: widget.investigation.notes);
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
            Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4.r)))),
            SizedBox(height: 16.h),
            Text(widget.investigation.name, style: AppTextStyle.bodyText1.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),

            Text('Urgency', style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              children: urgencyOptions.map((e) {
                final selected = widget.investigation.urgency == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: selected,
                  selectedColor: AppColor.primary.withOpacity(0.1),
                  onSelected: (_) => setState(() => widget.investigation.urgency = e),
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),

            TextField(
              controller: notesController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              onChanged: (v) => widget.investigation.notes = v,
            ),
            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { widget.onSave(widget.investigation); Navigator.pop(context); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.labletext,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
                ),
                child: Text('Add Investigation', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
