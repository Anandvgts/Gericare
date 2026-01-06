import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/follow_up/followup_view_model.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

class FollowUpNotesView extends StatelessWidget {
  const FollowUpNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FollowUpNotesViewModel>.reactive(
      viewModelBuilder: () => FollowUpNotesViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: const AppBarWidget(
            showBack: true,
            title: "Consultation",
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: "Close Consultation",
              onPressed: vm.submit,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Follow – up and Notes",
                    style: AppTextStyle.title1Bold
                        .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),

                /// FOLLOW UP DATE
                _DropdownField(
                  label: "Follow – Up",
                  hint: "Select Date",
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      initialDate: DateTime.now(),
                    );
                    if (date != null) {
                      vm.followUpDate = date;
                      vm.notifyListeners();
                    }
                  },
                  value: vm.followUpDate == null
                      ? null
                      : "${vm.followUpDate!.day}/"
                          "${vm.followUpDate!.month}/"
                          "${vm.followUpDate!.year}",
                ),

                const SizedBox(height: 16),

                /// REFERRAL
                _DropdownField(
                  label: "Referral",
                  hint: "Select",
                  value: vm.referral,
                  onTap: () {},
                ),

                const SizedBox(height: 16),

                /// PRESCRIPTION NOTES
                _TextArea(
                  label: "Prescription Notes",
                  controller: vm.prescriptionNotesCtrl,
                ),

                const SizedBox(height: 16),

                /// DOCTOR NOTES
                _TextArea(
                  label: "Doctor Notes",
                  controller: vm.doctorNotesCtrl,
                ),

                const SizedBox(height: 16),

                /// UPLOAD
                Text("Upload Attachments",
                    style: AppTextStyle.bodyText2Bold
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),

                GestureDetector(
                    onTap: vm.pickFile,
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: Radius.circular(12),
                        color: Colors.grey.shade400,
                        strokeWidth: 1,
                        dashPattern: const [6, 4],
                      ),

                      // ✅ FIXED
                      child: Container(
                        height: 110,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_photo_alternate_outlined, size: 28),
                            SizedBox(height: 8),
                            Text(
                              "Click a Snap",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    )),
                if (vm.uploadError != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    vm.uploadError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],

                const SizedBox(height: 16),

                /// UPLOADED FILES
                if (vm.files.isNotEmpty) ...[
                  Text("Uploaded Files",
                      style: AppTextStyle.bodyText2Bold
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  ...vm.files.map(
                    (f) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F4FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/main/consultation/image.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(f.name)),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
                            onPressed: () => vm.removeFile(f),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final VoidCallback onTap;

  const _DropdownField({
    required this.label,
    required this.hint,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyle.bodyText2Bold
                .copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: _borderedDecoration(
              hint: value ?? hint,
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            child: Text(value ?? hint),
          ),
        ),
      ],
    );
  }
}

class _TextArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _TextArea({
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodyText2Bold),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 4,
          decoration: _borderedDecoration(hint: "Enter notes"),
        ),
      ],
    );
  }
}

InputDecoration _borderedDecoration({
  required String hint,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyle.bodyText2SubText.copyWith(),
    suffixIcon: suffixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );
}
