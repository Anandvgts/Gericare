import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';

class IncidentReportView extends ConsumerWidget {
  final IncidentReportArgs args;

  const IncidentReportView({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarWidget(
        showBack: true,
        title: "Incident Report",
        subTitle: args.dateLabel,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Row(
            children: [
              Text(
                args.patientName,
                style: AppTextStyle.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  args.type,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            args.location,
            style: AppTextStyle.bodyText2SubText,
          ),
          const Divider(height: 32),
          _labelValue("Witness", args.witness),
          const Divider(height: 32),
          _labelValue("Notes", args.notes),
        ],
      ),
    );
  }

  Widget _labelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodyText2SubText),
        SizedBox(height: 6.h),
        Text(value, style: AppTextStyle.bodyText1),
      ],
    );
  }
}

class IncidentReportArgs {
  final String patientName;
  final String dateLabel;
  final String type;
  final String location;
  final String witness;
  final String notes;
  final List<String> attachments;

  IncidentReportArgs({
    required this.patientName,
    required this.dateLabel,
    required this.type,
    required this.location,
    required this.witness,
    required this.notes,
    required this.attachments,
  });
}
