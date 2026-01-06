import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';
import 'package:gericare_doctor/ui/widgets/time_line_card.dart';

class BloodSugarHistoryView extends StatefulWidget {
  const BloodSugarHistoryView({super.key});

  @override
  State<BloodSugarHistoryView> createState() => _BloodSugarHistoryViewState();
}

class _BloodSugarHistoryViewState extends State<BloodSugarHistoryView> {
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
        title: "Blood Sugar",
        subTitle: "Last Updated on Wed, Nov 7 2025",
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: bloodSugarLogs.map((log) {
          return TimelineRow(
            time: log.time,
            child: BloodSugarCard(log: log),
          );
        }).toList(),
      ),
    );
  }

  /// COMMON APP BAR
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

class BloodSugarCard extends StatelessWidget {
  final BloodSugarLog log;

  const BloodSugarCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
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
          /// ICON
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF1FF),
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/main/case_sheet/sugar_chart.png'),

          ),
          const SizedBox(width: 12),

          /// VALUE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${log.value} mg/dl",
                      style: AppTextStyle.bodyText2Bold
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),

                    /// RECORDED BY
                    Text(
                      log.recordedBy,
                      style:
                          AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  log.note,
                  style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BloodSugarLog {
  final String time;
  final int value;
  final String note;
  final String recordedBy;

  BloodSugarLog({
    required this.time,
    required this.value,
    required this.note,
    required this.recordedBy,
  });
}

final bloodSugarLogs = [
  BloodSugarLog(
    time: "8:10 AM",
    value: 108,
    note: "No order",
    recordedBy: "Priya Nair",
  ),
  BloodSugarLog(
    time: "12:35 PM",
    value: 106,
    note: "Before Food",
    recordedBy: "Priya Nair",
  ),
];
