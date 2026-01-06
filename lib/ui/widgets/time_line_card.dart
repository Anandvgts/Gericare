import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class TimelineRow extends StatelessWidget {
  final String time;
  final Widget child;

  const TimelineRow({
    required this.time,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TIME
          SizedBox(
            width: 72,
            child: Text(
              time,
              style: AppTextStyle.bodyText2SubText
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),

          /// CARD
          Expanded(child: child),
        ],
      ),
    );
  }
}
