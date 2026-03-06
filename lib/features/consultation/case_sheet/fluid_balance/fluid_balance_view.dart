import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'fluid_balance_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';

class FluidBalanceView extends ConsumerWidget {
  const FluidBalanceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fluidBalanceControllerProvider);
    final controller = ref.watch(fluidBalanceControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBarWidget(
        title: "Fluid Balance",
        isCalnder: true,
        bottom: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.formattedSelectedDate,
              style: AppTextStyle.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            DashboardCalendar(
              selectedDate: controller.selectedDate,
              onDateSelected: controller.onDateSelected,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _SectionTitle("Intake"),
          ...controller.intake.map(_FluidExpansionCard.new),
          SizedBox(height: 24.h),
          _SectionTitle("Output"),
          ...controller.output.map(_FluidExpansionCard.new),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyle.bodyText1.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FluidExpansionCard extends StatefulWidget {
  final FluidSection section;
  const _FluidExpansionCard(this.section);

  @override
  State<_FluidExpansionCard> createState() => _FluidExpansionCardState();
}

class _FluidExpansionCardState extends State<_FluidExpansionCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => setState(() => expanded = !expanded),
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.section.title,
                      style: AppTextStyle.bodyText1.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if (!expanded) ...[
            const SizedBox(),
            const Divider(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              color: const Color(0xFFF3F4F6),
              child: Row(
                children: widget.section.headers
                    .map((h) => Expanded(
                          child: Text(
                            h,
                            style: AppTextStyle.bodyText2SubText,
                          ),
                        ))
                    .toList(),
              ),
            ),
            ...widget.section.rows.map(
              (row) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(child: Text(row.time)),
                    Expanded(child: Text(row.nature)),
                    Expanded(child: Text(row.value)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
