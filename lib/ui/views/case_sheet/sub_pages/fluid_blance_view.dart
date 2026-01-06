import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/helper.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/app_bar_widget.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';

class FluidBalanceView extends StatefulWidget {
  const FluidBalanceView({super.key});

  @override
  State<FluidBalanceView> createState() => _FluidBalanceViewState();
}

class _FluidBalanceViewState extends State<FluidBalanceView> {
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
          context, "Fluid Balance", " Last Updated on Wed, Nov 7 2025"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // const SizedBox(height: 24),

          /// INTAKE
          Text(
            "Intake",
            style: AppTextStyle.title1Bold.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 12),

          FluidExpansionCard(
            title: "Oral",
            headers: const ["Time", "Nature", "ML"],
            rows: [
              FluidRow(time: "8:35 AM", nature: "Food", value: "150 ml"),
              FluidRow(time: "9:40 AM", nature: "Curd", value: "100 ml"),
              FluidRow(time: "10:50 AM", nature: "Tab + H2O", value: "200 ml"),
            ],
          ),

          FluidExpansionCard(
            title: "Ryle’s Tube Feeding",
            headers: const ["Time", "Nature", "ML"],
            rows: [
              FluidRow(time: "8:35 AM", nature: "H2O", value: "50 ml"),
              FluidRow(time: "9:40 AM", nature: "Tab", value: "10 ml"),
              FluidRow(time: "10:50 AM", nature: "Coffee", value: "20 ml"),
            ],
          ),

          FluidExpansionCard(
            title: "IV Fluids and Blood/Blood Products",
            headers: const ["Time", "Type", "ML"],
            rows: [
              FluidRow(time: "10:50 AM", nature: "Coffee", value: "20 ml"),
            ],
          ),

          const SizedBox(height: 24),

          /// OUTPUT
          Text(
            "Output",
            style: AppTextStyle.title1Bold.copyWith(
              fontSize: 16,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 12),

          FluidExpansionCard(
            title: "Urine",
            headers: const ["Time", "", "ML"],
            rows: [
              FluidRow(time: "8:35 AM", nature: "", value: "150 ml"),
              FluidRow(time: "9:40 AM", nature: "", value: "100 ml"),
              FluidRow(time: "10:50 AM", nature: "", value: "200 ml"),
            ],
          ),

          FluidExpansionCard(
            title: "Ryle’s Tube Aspirate (ml)",
            headers: const ["Time", "", "ML"],
            rows: [
              FluidRow(time: "10:50 AM", nature: "", value: "200 ml"),
            ],
          ),

          FluidExpansionCard(
            title: "Drain",
            headers: const ["Time", "", "ML"],
            rows: [
              FluidRow(time: "10:50 AM", nature: "", value: "200 ml"),
            ],
          ),

          FluidExpansionCard(
            title: "Motion Passed",
            headers: const ["Time", "", "Times"],
            rows: [
              FluidRow(time: "10:50 AM", nature: "", value: "2"),
            ],
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

class FluidExpansionCard extends StatefulWidget {
  final String title;
  final List<FluidRow> rows;
  final List<String> headers;

  const FluidExpansionCard({
    super.key,
    required this.title,
    required this.rows,
    required this.headers,
  });

  @override
  State<FluidExpansionCard> createState() => _FluidExpansionCardState();
}

class _FluidExpansionCardState extends State<FluidExpansionCard> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        children: [
          /// HEADER
          InkWell(
            onTap: () => setState(() => expanded = !expanded),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: AppTextStyle.bodyText2Bold
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ),

          if (expanded) ...[
            const Divider(height: 1),

            /// TABLE HEADER
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              color: Color(0xFFF3F4F6),
              child: Row(
                children: widget.headers
                    .map(
                      (h) => Expanded(
                        child: Text(
                          h,
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Divider(height: 1, color: colors.outlineVariant),

            /// ROWS
            ...widget.rows.map((row) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          row.time,
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )),
                        Expanded(
                            child: Text(
                          row.nature,
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )),
                        Expanded(
                            child: Text(
                          row.value,
                          style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: colors.outlineVariant),
                ],
              );
            }),
          ],
        ],
      ),
    );
  }
}

class FluidRow {
  final String time;
  final String nature;
  final String value;

  FluidRow({
    required this.time,
    required this.nature,
    required this.value,
  });
}

class FluidSection {
  final String title;
  final List<FluidRow> rows;

  FluidSection({
    required this.title,
    required this.rows,
  });
}
