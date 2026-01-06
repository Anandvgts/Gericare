import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/incident_report_view.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';
import 'package:gericare_doctor/ui/widgets/time_line_card.dart';

class IncidentHistoryView extends StatefulWidget {
  const IncidentHistoryView({super.key});

  @override
  State<IncidentHistoryView> createState() => _IncidentHistoryViewState();
}

class _IncidentHistoryViewState extends State<IncidentHistoryView> {
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
        "Incidents",
        "Last Updated on Wed, Nov 7 2025",
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TimelineRow(
            time: Helper.formatTime(
              DateTime.now().copyWith(hour: 8, minute: 10),
            ),
            child: IncidentCard(
              title: "Incident Log 1",
              recorder: "Priya Nair",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const IncidentReportView(),
                  ),
                );
              },
            ),
          ),
          TimelineRow(
            time: Helper.formatTime(
              DateTime.now().copyWith(hour: 12, minute: 35),
            ),
            child: IncidentCard(
              title: "Incident Log 2",
              recorder: "Vinay Kumar",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const IncidentReportView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize _buildAppBar(
      BuildContext context, String title, String subTitle) {
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

class IncidentCard extends StatelessWidget {
  final String title;
  final String recorder;
  final VoidCallback onTap;

  const IncidentCard({
    super.key,
    required this.title,
    required this.recorder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
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
              child:Image.asset('assets/main/case_sheet/incident_report.png'),

            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.bodyText2Bold),
                  const SizedBox(height: 4),
                  Text(
                    "Recorded by $recorder",
                    style: AppTextStyle.bodyText2SubText,
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

