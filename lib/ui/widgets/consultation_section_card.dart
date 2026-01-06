import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_history/ch_details/ch_details_view_model.dart';

class ConsultationSectionCard extends StatelessWidget {
  final bool showChange;
  final VoidCallback? onChange;
  final ConsultationDetailSection section;

  const ConsultationSectionCard({
    super.key,
    required this.section,
    this.showChange = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildContent(context),

          if (showChange) ...[
            const SizedBox(height: 8),
            Align(
              alignment: section.layoutType != SectionLayoutType.twoColumn
                  ? Alignment.centerLeft
                  : Alignment.center,
              child: GestureDetector(
                onTap: onChange,
                child: Text(
                  "Change",
                  style: AppTextStyle.bodyText2.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ]
// 👈 THIS decides which layout
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (section.layoutType) {
      case SectionLayoutType.vitals:
        return _buildVitals(context);

      case SectionLayoutType.bullet:
        return _buildBulletList();

      case SectionLayoutType.groupedBullet:
        return _buildGroupedBulletList();

      case SectionLayoutType.twoColumn:
      default:
        return _buildTwoColumn(context);
    }
  }

  Widget _buildTwoColumn(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: section.rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(row.left,
                    style: AppTextStyle.bodyText2
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyle.bodyText2SubText,
                    children: [
                      if (row.rightLabel != null)
                        TextSpan(text: "${row.rightLabel} : "),
                      TextSpan(
                        text: row.rightValue,
                        style: AppTextStyle.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                          color: row.status == "Stopped" ? Colors.red : null,
                        ),
                      ),
                      if (row.extraLabel != null && row.extraValue != null) ...[
                        const TextSpan(text: "\n"),
                        TextSpan(text: "${row.extraLabel} : "),
                        TextSpan(
                          text: row.extraValue!,
                          style: AppTextStyle.bodyText2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVitals(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: section.rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// LEFT LABEL
              Expanded(
                flex: 2,
                child: Text(
                  row.left,
                  style: AppTextStyle.bodyText2
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      row.rightValue ?? "",
                      style: AppTextStyle.bodyText2
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 8),
                    if (row.status != null)
                      Text(
                        row.status ?? "Norm",
                        style: AppTextStyle.bodyText2.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBulletList() {
    final items = section.groupedItems?.values.first ?? [];

    return Column(
      children: items.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("•  "),
              Expanded(
                  child: Text(e,
                      style: AppTextStyle.bodyText2.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400))),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGroupedBulletList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: section.groupedItems!.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.key,
              style: AppTextStyle.bodyText2Bold
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            ...entry.value.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Text("•  "),
                      Expanded(
                          child: Text(
                        item,
                        style: AppTextStyle.bodyText2.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5EE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(section.icon, width: 18),
          ),
        ),
        const SizedBox(width: 12),
        Text(section.title,
            style: AppTextStyle.title1Bold
                .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
