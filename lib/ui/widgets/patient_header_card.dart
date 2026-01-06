import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class PatientHeader extends StatelessWidget {
  final String name;
  final String gender;
  final int age;

  const PatientHeader({
    super.key,
    required this.name,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyle.title1Bold
              .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          "$gender  •  $age Yrs",
          style: AppTextStyle.bodyText2SubText.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
