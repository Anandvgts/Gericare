import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';

class MedicationsView extends StatefulWidget {
  const MedicationsView({super.key});

  @override
  State<MedicationsView> createState() => _MedicationsViewState();
}

class _MedicationsViewState extends State<MedicationsView> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() => selectedDate = date);
  }

  String getFormattedDate() {
    return "Wednesday, 7 Nov"; // dummy
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBarWidget(
          title: "Medications",
          showBack: true,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getFormattedDate(),
                    style: AppTextStyle.title1Bold
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  // const SizedBox(height: 8),

                  /// CALENDAR
                  HorizontalCalendar(
                    selectedDate: selectedDate,
                    onDateSelected: onDateSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomActions(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// DATE TITLE

          const SizedBox(height: 12),

          /// SECTIONS
          _MedicationSection("Morning", dummyMorning),
          const SizedBox(height: 16),
          _MedicationSection("After Noon", dummyAfternoon),
          const SizedBox(height: 16),
          _MedicationSection("Night", dummyNight),
        ],
      ),
    );
  }
}

class _MedicationSection extends StatelessWidget {
  final String title;
  final List<MedicationItem> items;

  const _MedicationSection(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyle.bodyText2Bold
                .copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x296C849D)),
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              final isLast = i == items.length - 1;
              return Column(
                children: [
                  _MedicationTile(item: items[i]),
                  if (!isLast)
                    const Divider(height: 1, color: Color(0xFFE6E8EC)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _MedicationTile extends StatelessWidget {
  final MedicationItem item;

  const _MedicationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          _StatusIcon(item.status),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.name} – ${item.dose}",
                  style: AppTextStyle.bodyText2Bold
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: AppTextStyle.bodyText2SubText.copyWith(
                      color: item.status == MedicationStatus.refused
                          ? const Color(0xFFD32F2F)
                          : null,
                      fontSize: 12,
                      fontWeight: item.status == MedicationStatus.refused
                          ? FontWeight.w500
                          : FontWeight.w400),
                ),
              ],
            ),
          ),
          const Icon(Icons.remove_circle_outline,
              color: Color(0xFFD32F2F), size: 22),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final MedicationStatus status;

  const _StatusIcon(this.status);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MedicationStatus.taken:
        return _circle(Icons.check, const Color(0xFF66BB6A), Colors.white);
      case MedicationStatus.refused:
        return _circle(Icons.close, const Color(0xFFEF9A9A), Colors.red);
      case MedicationStatus.skipped:
      default:
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400),
          ),
        );
    }
  }

  Widget _circle(IconData icon, Color color, Color iconColor) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 12, color: iconColor),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF40AE72),
                backgroundColor: Color(0x2940AE72),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text("Add Medication",
                  style: AppTextStyle.buttonLabel
                      .copyWith(color: const Color(0xFF40AE72))),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 2,
              ),
              onPressed: () {},
              child: Text("Update", style: AppTextStyle.buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}

enum MedicationStatus { taken, refused, skipped }

class MedicationItem {
  final String name;
  final String dose;
  final String subtitle;
  final MedicationStatus status;

  MedicationItem({
    required this.name,
    required this.dose,
    required this.subtitle,
    required this.status,
  });
}

final dummyMorning = [
  MedicationItem(
    name: "T.PHLOGAM FORTE",
    dose: "1 Tablet",
    subtitle: "Before Meal",
    status: MedicationStatus.taken,
  ),
  MedicationItem(
    name: "T.Shelcal-XT",
    dose: "1 ml",
    subtitle: "Refused – Refused to take medicine",
    status: MedicationStatus.refused,
  ),
  MedicationItem(
    name: "Montek LC (10 & 5)",
    dose: "1 Tablet",
    subtitle: "Every 4 Hours – 1st Time",
    status: MedicationStatus.skipped,
  ),
];

final dummyAfternoon = [
  MedicationItem(
    name: "Bilasure M",
    dose: "1 Tablet",
    subtitle: "Before Meal",
    status: MedicationStatus.taken,
  ),
];

final dummyNight = [
  MedicationItem(
    name: "T.SHELCAL-XT",
    dose: "1 Tablet",
    subtitle: "Every 4 Hours – 3rd Time",
    status: MedicationStatus.skipped,
  ),
];
