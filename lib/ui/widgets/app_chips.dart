import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool showWarning;
  final Color? bgColor;
  final Color? brColor;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final VoidCallback? onWarningTap;

  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.showWarning = false,
    this.bgColor,
    this.brColor,
    this.onTap,
    this.onRemove,
    this.onWarningTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final borderColor = showWarning
        ? colors.primary
        : selected
            ? brColor ?? colors.primary
            : colors.outlineVariant;

    final backgroundColor = selected
        ? bgColor ?? colors.primary.withOpacity(0.06)
        : Colors.transparent;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 12 : 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showWarning) ...[
              GestureDetector(
                onTap: onWarningTap,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Color(0xFFB42318),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.priority_high,
                    size: 12,
                    color: colors.onError,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],

            Text(
              label,
              style: AppTextStyle.bodyText2.copyWith(
                color: selected ? colors.onSurface : Color(0xFF7A7A7A),
                fontWeight: FontWeight.w400,
              ),
            ),

            /// ❌ REMOVE ICON (ONLY WHEN SELECTED)
            if (selected && onRemove != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12,
                    // color: colors.onPrimary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddMoreChip extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const AddMoreChip({
    super.key,
    required this.onTap,
    this.label = "Add More",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
