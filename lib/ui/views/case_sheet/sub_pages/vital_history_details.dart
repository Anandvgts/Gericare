import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';

class VitalsDetailView extends StatelessWidget {
  final DateTime dateTime;

  const VitalsDetailView({super.key, required this.dateTime});

  bool get isToday {
    final now = DateTime.now();
    return now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBarWidget(
        showBack: true,
        title: isToday ? "Vitals – Today" : "Vitals",
        subtitle: "Recorded at ${Helper.formatTime(dateTime)}",
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:
            _dummySections.map((e) => VitalSectionCard(section: e)).toList(),
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

          /// GRID
          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: section.values.length,
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 12,
          //     crossAxisSpacing: 12,
          //     childAspectRatio: 1.4,
          //   ),
          //   itemBuilder: (_, i) => VitalTile(data: section.values[i]),
          // ),
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

enum VitalStatus { normal, mild, moderate, hypotension, nonDiabetic }

class VitalValue {
  final String label;
  final String value;
  final String unit;
  final VitalStatus status;
  final bool fullWidth;

  VitalValue({
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    this.fullWidth = false,
  });
}

class VitalSection {
  final String title;
  final IconData icon;
  final List<VitalValue> values;

  VitalSection({
    required this.title,
    required this.icon,
    required this.values,
  });
}

final _dummySections = [
  VitalSection(
    title: "Blood Pressure",
    icon: Icons.water_drop_outlined,
    values: [
      VitalValue(
          label: "Lying",
          value: "98",
          unit: "mmHg",
          status: VitalStatus.normal),
      VitalValue(
          label: "Sitting",
          value: "98",
          unit: "mmHg",
          status: VitalStatus.hypotension),
      VitalValue(
          label: "Standing",
          value: "101",
          unit: "mmHg",
          status: VitalStatus.hypotension),
    ],
  ),
  VitalSection(
    title: "Heart & Respiratory",
    icon: Icons.favorite_outline,
    values: [
      VitalValue(
          label: "Pulse", value: "98", unit: "", status: VitalStatus.normal),
      VitalValue(
          label: "SPO₂", value: "98", unit: "%", status: VitalStatus.normal),
      VitalValue(
          label: "Temperature",
          value: "98.6",
          unit: "°F",
          status: VitalStatus.normal),
      VitalValue(
          label: "Temperature",
          value: "98.6",
          unit: "°F",
          status: VitalStatus.normal),
    ],
  ),
  VitalSection(
    title: "Measurements",
    icon: Icons.straighten,
    values: [
      VitalValue(
          label: "Blood Sugar",
          value: "143",
          unit: "mg/dl",
          status: VitalStatus.nonDiabetic,
          fullWidth: true),
    ],
  ),
  VitalSection(
    title: "Output & Score",
    icon: Icons.assessment_outlined,
    values: [
      VitalValue(
          label: "Pain Score",
          value: "5/10",
          unit: "",
          status: VitalStatus.mild,
          fullWidth: true),
      VitalValue(
          label: "Urine Output",
          value: "5",
          unit: "",
          status: VitalStatus.moderate),
      VitalValue(
          label: "Stool Output",
          value: "2",
          unit: "/day",
          status: VitalStatus.normal),
    ],
  ),
];
