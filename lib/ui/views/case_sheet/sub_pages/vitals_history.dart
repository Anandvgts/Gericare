import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';
import 'package:gericare_doctor/ui/widgets/time_line_card.dart';

class VitalsHistoryView extends StatefulWidget {
  const VitalsHistoryView({super.key});

  @override
  State<VitalsHistoryView> createState() => _VitalsHistoryViewState();
}

class _VitalsHistoryViewState extends State<VitalsHistoryView> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() => selectedDate = date);
  }

  String getFormattedDate() => "Wednesday, 7 Nov";

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(
          context, "Vitals History", " Last Updated on Wed, Nov 7 2025"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TimelineRow(
            time: "8:10 AM",
            child: VitalsHistoryCard(
              title: "Vitals Log 1",
              recordedBy: "Priya Nair",
            ),
          ),
          TimelineRow(
            time: "12:35 PM",
            child: VitalsHistoryCard(
              title: "Vitals Log 2",
              recordedBy: "Vinay Kumar",
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getFormattedDate(),
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

class VitalsHistoryCard extends StatelessWidget {
  final String title;
  final String recordedBy;

  const VitalsHistoryCard({
    super.key,
    required this.title,
    required this.recordedBy,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        navigationService.pushNamed(
          Routes.csVitalsHistoryDetails,
          arguments: {'dateTime': DateTime.now()},
        );
      },
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
                color: Color(0xFFF0F1FF),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/main/case_sheet/vitals.png',
                // width: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyText2Bold.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Recorded by $recordedBy",
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
