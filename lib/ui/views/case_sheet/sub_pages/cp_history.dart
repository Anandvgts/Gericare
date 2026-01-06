import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';
import 'package:gericare_doctor/ui/widgets/time_line_card.dart';

class CarePlanHistoryView extends StatefulWidget {
  const CarePlanHistoryView({super.key});

  @override
  State<CarePlanHistoryView> createState() => _CarePlanHistoryViewState();
}

class _CarePlanHistoryViewState extends State<CarePlanHistoryView> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(
        context,
        title: "Care Plan History",
        subTitle: "Last Updated on Wed, Nov 7 2025",
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: carePlanLogs.map((log) {
          return TimelineRow(
            time: log.time,
            child: CarePlanCard(log: log),
          );
        }).toList(),
      ),
    );
  }

  PreferredSize _buildAppBar(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180),
      child: AppBarWidget(
        title: title,
        subtitle: subTitle,
        showBack: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Helper.getFormattedDate(),
                  style: AppTextStyle.title1Bold.copyWith(fontSize: 16),
                ),
                HorizontalCalendar(
                  selectedDate: selectedDate,
                  onDateSelected: onDateSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarePlanCard extends StatelessWidget {
  final CarePlanLog log;

  const CarePlanCard({super.key, required this.log});

  void showCarePlanBottomSheet(BuildContext context, CarePlanLog log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CarePlanBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => showCarePlanBottomSheet(context, log),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF1FF),
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/main/case_sheet/care_plan.png'),
            ),
            const SizedBox(width: 12),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log.title,
                    style: AppTextStyle.bodyText2Bold
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Recorded by ${log.recordedBy}",
                    style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class CarePlanBottomSheet extends StatelessWidget {
  const CarePlanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// DRAG HANDLE
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// TITLE
          Text(
            "Care Plan",
            style: AppTextStyle.title1Bold
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),

          /// DATE
          Text(
            "Wed, Nov 7 2025, 8:10 AM",
            style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
          ),

          const SizedBox(height: 24),

          /// STATUS LIST
          ...carePlanStatusItems.map(
            (item) => CarePlanStatusRow(item: item),
          ),
        ],
      ),
    );
  }
}

class CarePlanStatusRow extends StatelessWidget {
  final CarePlanStatusItem item;

  const CarePlanStatusRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item.isDone ? Colors.green : Colors.red.shade100;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          /// STATUS ICON
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isDone ? Icons.check : Icons.close,
              color: item.isDone ? Colors.white : Colors.red,
              size: 16,
            ),
          ),

          const SizedBox(width: 12),

          /// LABEL
          Text(
            item.label,
            style: AppTextStyle.bodyText2.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class CarePlanLog {
  final String time;
  final String title;
  final String recordedBy;

  CarePlanLog({
    required this.time,
    required this.title,
    required this.recordedBy,
  });
}

final carePlanLogs = [
  CarePlanLog(
    time: "8:10 AM",
    title: "Care Plan Log 1",
    recordedBy: "Priya Nair",
  ),
  CarePlanLog(
    time: "12:35 PM",
    title: "Care Plan Log 2",
    recordedBy: "Vinay Kumar",
  ),
];

class CarePlanStatusItem {
  final String label;
  final bool isDone;

  CarePlanStatusItem({
    required this.label,
    required this.isDone,
  });
}

final carePlanStatusItems = [
  CarePlanStatusItem(label: "Slept Well", isDone: true),
  CarePlanStatusItem(label: "Perineal Care", isDone: true),
  CarePlanStatusItem(label: "Skin Care", isDone: true),
  CarePlanStatusItem(label: "Feeding", isDone: false),
  CarePlanStatusItem(label: "Motion Passed", isDone: false),
  CarePlanStatusItem(label: "Medicines Given", isDone: true),
];
