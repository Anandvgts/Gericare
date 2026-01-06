import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_history/consultation_history_view_model.dart';

class HistoryListItem extends StatelessWidget {
  final ConsultationHistoryItem data;
  final VoidCallback onTap;

  const HistoryListItem({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TIME (LEFT)
          SizedBox(
            width: 75, // fixed width like Figma
            child: Text(
              data.time,
              style: AppTextStyle.bodyText2SubText,
            ),
          ),
          SizedBox(
            width: 24,
          ),

          /// CARD (RIGHT)
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    /// AVATAR
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/main/ch_profile.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    /// DETAILS
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.doctor,
                            style: AppTextStyle.title1Bold.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data.speciality,
                            style: AppTextStyle.bodyText2SubText.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 6),
                          _buildTypeText(data.type),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeText(String text) {
    final parts = text.split('-');

    if (parts.length < 2) {
      return Text(text, style: AppTextStyle.bodyText2);
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${parts[0].trim()} – ',
            style: AppTextStyle.bodyText2SubText
                .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: parts[1].trim(),
            style: AppTextStyle.bodyText2.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
