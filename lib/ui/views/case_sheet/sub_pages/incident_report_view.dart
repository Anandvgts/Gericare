import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';

class IncidentReportView extends StatelessWidget {
  const IncidentReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBarWidget(
        
        showBack: true,
        title: "Incident Report",
        subtitle: "2:30 AM, Fri 21 Aug, 2025",

      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// NAME + TAG
          Row(
            children: [
              Text("John Doe",
                  style: AppTextStyle.title1Bold
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Injury",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
          Text(
            "Ward A  •  104 A",
            style: AppTextStyle.bodyText2SubText
                .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),

          const Divider(height: 32),

          /// WITNESS
          _LabelValue(label: "Witness", value: "Mr. Prithvi Raj"),

          const Divider(height: 32),

          /// NOTES
          _LabelValue(
            label: "Notes",
            value:
                "Fell down from the bed and got injured in the leg, look like a predominance bone crack.",
          ),

          const SizedBox(height: 24),

          /// ATTACHMENTS
          Text("Attachments",
              style: AppTextStyle.bodyText2Bold
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyle.bodyText2SubText
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 6),
        Text(value,
            style: AppTextStyle.bodyText2
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
