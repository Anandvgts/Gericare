import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/consultation/case_sheet/vitals/vitals_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsDetailView extends ConsumerWidget {
  const VitalsDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(vitalsControllerProvider);
    final controller = ref.watch(vitalsControllerProvider.notifier);
    final log = controller.selectedLog!;

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBarWidget(
        showBack: true,
        title: controller.isToday ? "Vitals – Today" : "Vitals",
        subTitle: "Recorded at ${controller.formatTime(log.dateTime)}",
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: controller.sections
            .map((s) => VitalSectionCard(section: s))
            .toList(),
      ),
    );
  }
}

class VitalSectionCard extends StatelessWidget {
  final VitalSection section;

  const VitalSectionCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(section.icon, size: 18, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Text(section.title,
                  style: AppTextStyle.title1Bold
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),

          const SizedBox(height: 16),
          _buildValues(),
        ],
      ),
    );
  }

  Widget _buildValues() {
    final fullWidthItems = section.values.where((e) => e.fullWidth).toList();
    final gridItems = section.values.where((e) => !e.fullWidth).toList();

    return Column(
      children: [
        /// FULL WIDTH ITEMS
        ...fullWidthItems.map(
          (e) => Container(
            padding: const EdgeInsets.only(bottom: 12),
            width: double.infinity,
            child: VitalTile(data: e),
          ),
        ),

        /// GRID ITEMS
        if (gridItems.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2,
            ),
            itemBuilder: (_, i) => VitalTile(data: gridItems[i]),
          ),
      ],
    );
  }
}

Color vitalStatusColor(VitalStatus status) {
  switch (status) {
    case VitalStatus.normal:
      return Colors.green;
    case VitalStatus.mild:
      return Colors.green;
    case VitalStatus.moderate:
      return Colors.orange;
    case VitalStatus.hypotension:
      return Colors.red;
    case VitalStatus.nonDiabetic:
      return Colors.green;
  }
}

class VitalTile extends StatelessWidget {
  final VitalValue data;

  const VitalTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final color = vitalStatusColor(data.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.label,
              style: AppTextStyle.bodyText2
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 6),
          // Text(
          //   "${data.value} ${data.unit}",
          //   style: AppTextStyle.title1Bold.copyWith(fontSize: 16),
          // ),
          RichText(
            text: TextSpan(
              text: data.value,
              style: AppTextStyle.title1Bold
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: " ${data.unit}",
                  style: AppTextStyle.title1Bold.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            vitalStatusLabel(data.status),
            style: AppTextStyle.bodyText2.copyWith(
                fontSize: 12, fontWeight: FontWeight.w500, color: color),
          ),
        ],
      ),
    );
  }
}

String vitalStatusLabel(VitalStatus status) {
  switch (status) {
    case VitalStatus.normal:
      return "Normal";
    case VitalStatus.mild:
      return "Mild";
    case VitalStatus.moderate:
      return "Moderate";
    case VitalStatus.hypotension:
      return "Hypotension";
    case VitalStatus.nonDiabetic:
      return "Non-diabetic";
  }
}
