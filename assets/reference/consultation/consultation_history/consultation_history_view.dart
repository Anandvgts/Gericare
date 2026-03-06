import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/history_line_item.dart';
import 'package:stacked/stacked.dart';
import 'consultation_history_view_model.dart';

class ConsultationHistoryView extends StatelessWidget {
  const ConsultationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ViewModelBuilder<ConsultationHistoryViewModel>.reactive(
      viewModelBuilder: () => ConsultationHistoryViewModel(),
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBarWidget(
              showBack: true,
              title: "Consultation History",
              subtitle: "Last Updated on Wed, Nov 7 2025",
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: colors.outlineVariant,
                ),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: viewModel.groupedHistory.entries
                .toList()
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final date = entry.value.key;
              final items = entry.value.value;

              final isLatest = index == 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// DATE HEADER
                  if (isLatest)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        _dayLabel(date), // Wednesday
                        style: AppTextStyle.title1Bold.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                  else
                    _DateDivider(label: _fullDateLabel(date)), // Sun, June 6

                  /// HISTORY ITEMS
                  ...items.map(
                    (item) => HistoryListItem(
                      data: item,
                      onTap: () => viewModel.openDetails(item),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

String _dayLabel(DateTime date) {
  return [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ][date.weekday - 1];
}

String _fullDateLabel(DateTime date) {
  return "${_dayLabel(date).substring(0, 3)}, "
      "${date.day} "
      "${_monthLabel(date.month)}";
}

String _monthLabel(int m) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[m - 1];
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
