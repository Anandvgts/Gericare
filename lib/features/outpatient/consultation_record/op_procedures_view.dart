import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/consultation_record/op_procedures_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpProceduresView extends ConsumerWidget {
  final String consultationId;

  const OpProceduresView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opProceduresControllerProvider(consultationId));
    final controller = ref.watch(opProceduresControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: const AppBarWidget(title: 'Procedures'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))],
        ),
        child: ElevatedButton(
          onPressed: controller.selectedProcedures.isNotEmpty ? controller.onSaveProcedures : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.labletext,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColor.labletext.withOpacity(0.5),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
          ),
          child: Text('Save Procedures', style: TextStyle(fontWeight: FontWeight.w600)),
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
                  hintText: 'Search procedures',
                  hintStyle: AppTextStyle.bodyText2SubText,
                  prefixIcon: Icon(Icons.search, color: AppColor.secondaryText),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// SELECTED PROCEDURES
            if (controller.selectedProcedures.isNotEmpty) ...[
              Text('Selected Procedures', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              ...controller.selectedProcedures.map((procedure) {
                return _ProcedureCard(
                  procedure: procedure,
                  onRemove: () => controller.removeProcedure(procedure),
                );
              }),
              SizedBox(height: 24.h),
            ],

            /// AVAILABLE PROCEDURES
            Text('Procedures', style: AppTextStyle.bodyText1.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),

            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ...controller.filteredProcedures.map(
                      (procedure) => _ProcedureChip(
                        label: procedure,
                        onTap: () => controller.toggleProcedure(context, procedure),
                      ),
                    ),
                    if (controller.canCreate)
                      _ProcedureChip(
                        label: '+ Create "${controller.searchText}"',
                        onTap: () => controller.createProcedure(context),
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

class _ProcedureChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _ProcedureChip({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.containerOutline),
        ),
        child: Text(label, style: AppTextStyle.bodyText2),
      ),
    );
  }
}

class _ProcedureCard extends StatelessWidget {
  final ProcedureItem procedure;
  final VoidCallback onRemove;

  const _ProcedureCard({required this.procedure, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(procedure.name, style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w600)),
                if (procedure.notes != null && procedure.notes!.isNotEmpty)
                  Text(procedure.notes!, style: AppTextStyle.caption.copyWith(color: AppColor.secondaryText)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 18, color: AppColor.secondaryText),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class ProcedureDetailsBottomSheet extends StatefulWidget {
  final ProcedureItem procedure;
  final ValueChanged<ProcedureItem> onSave;

  const ProcedureDetailsBottomSheet({super.key, required this.procedure, required this.onSave});

  @override
  State<ProcedureDetailsBottomSheet> createState() => _ProcedureDetailsBottomSheetState();
}

class _ProcedureDetailsBottomSheetState extends State<ProcedureDetailsBottomSheet> {
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(text: widget.procedure.notes);
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
            Text(widget.procedure.name, style: AppTextStyle.bodyText1.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),

            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Notes',
                hintText: 'Add procedure details...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              onChanged: (v) => widget.procedure.notes = v,
            ),
            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { widget.onSave(widget.procedure); Navigator.pop(context); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.labletext,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
                ),
                child: Text('Add Procedure', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
