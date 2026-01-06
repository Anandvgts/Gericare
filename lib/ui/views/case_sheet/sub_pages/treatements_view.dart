import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';

class TreatmentsView extends StatefulWidget {
  const TreatmentsView({super.key});

  @override
  State<TreatmentsView> createState() => _TreatmentsViewState();
}

class _TreatmentsViewState extends State<TreatmentsView> {
  DateTime selectedDate = DateTime.now();

  void onDateSelected(DateTime date) {
    setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final grouped = <DateTime, List<TreatmentItem>>{};

    for (final item in dummyTreatments) {
      final date = DateTime(
        item.dateTime.year,
        item.dateTime.month,
        item.dateTime.day,
      );
      grouped.putIfAbsent(date, () => []).add(item);
    }

    final dates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(
          context, "Treatments", "Last Updated on Wed, Nov 7 2025"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(dates.length, (index) {
          final date = dates[index];
          final items = grouped[date]!;
          final isLatest = index == 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TODAY LABEL OR DATE DIVIDER
              if (isLatest)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Today",
                    style: AppTextStyle.title1Bold.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                _DateDivider(label: Helper.fullDateLabel(date)),

              /// ITEMS
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TreatmentRow(item: item),
                ),
              ),
            ],
          );
        }),
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

class _DateDivider extends StatelessWidget {
  final String label;

  const _DateDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: colors.outlineVariant)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.outlineVariant),
            ),
            child: Text(
              label,
              style: AppTextStyle.bodyText2.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: Divider(color: colors.outlineVariant)),
        ],
      ),
    );
  }
}

class TreatmentItem {
  final DateTime dateTime;
  final String title;
  final String subtitle;
  final String therapist;
  final String referredBy;

  TreatmentItem({
    required this.dateTime,
    required this.title,
    required this.subtitle,
    required this.therapist,
    required this.referredBy,
  });
}

final List<TreatmentItem> dummyTreatments = [
  TreatmentItem(
    dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
    title: "DBE/AAROM to B/L UL/LL",
    subtitle: "Ambulate to WC",
    therapist: "Dr. Harish Kanth",
    referredBy: "Dr. Krishna Kumar",
  ),
  TreatmentItem(
    dateTime: DateTime.now().subtract(const Duration(days: 1)).copyWith(
          hour: 12,
          minute: 35,
        ),
    title: "DBE/AAROM to B/L UL/LL",
    subtitle: "",
    therapist: "Dr. Harish Kanth",
    referredBy: "Dr. Krishna Kumar",
  ),
];

class TreatmentRow extends StatelessWidget {
  final TreatmentItem item;

  const TreatmentRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TIME
        SizedBox(
          width: 72,
          child: Text(
            Helper.formatTime(item.dateTime),
            style: AppTextStyle.bodyText2SubText,
          ),
        ),

        const SizedBox(width: 12),

        /// CARD (NOT FULL WIDTH ❗)
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ICON
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F1FF),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/main/treatment_history.png'),
                ),
                const SizedBox(width: 12),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTextStyle.bodyText2Bold.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      if (item.subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle,
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          text: "Therapist : ",
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7A7A7A)),
                          children: [
                            TextSpan(
                              text: item.therapist,
                              style: AppTextStyle.bodyText2SubText
                                  .copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Referred : ",
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7A7A7A)),
                          children: [
                            TextSpan(
                              text: item.referredBy,
                              style: AppTextStyle.bodyText2SubText
                                  .copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
