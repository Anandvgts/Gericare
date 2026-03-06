import 'package:doctor/core/styles/colors.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:doctor/features/outpatient/op_vitals_controller.dart';
import 'package:doctor/features/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpVitalsView extends ConsumerWidget {
  final String consultationId;

  const OpVitalsView({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opVitalsControllerProvider(consultationId));
    final controller = ref.watch(opVitalsControllerProvider(consultationId).notifier);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBarWidget(title: 'Details'),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (_) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// PAIN SCALE
                    _PainScaleSection(
                      selectedPainLevel: controller.painLevel,
                      onPainLevelSelected: controller.onPainLevelSelected,
                    ),

                    SizedBox(height: 32.h),

                    /// VITALS GRID - Horizontal scrollable for mobile
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 260.w,
                            child: _BloodPressureSection(controller: controller),
                          ),
                          SizedBox(width: 16.w),
                          SizedBox(
                            width: 280.w,
                            child: _HeartRespiratorySection(controller: controller),
                          ),
                          SizedBox(width: 16.w),
                          SizedBox(
                            width: 260.w,
                            child: _MeasurementsSection(controller: controller),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// BOTTOM BUTTONS
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: AppColor.secondaryText, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  ElevatedButton(
                    onPressed: controller.onSaveVitals,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.labletext,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text('Save Vitals', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pain Scale Section - Circular emoji buttons (0-10)
class _PainScaleSection extends StatelessWidget {
  final int? selectedPainLevel;
  final ValueChanged<int> onPainLevelSelected;

  const _PainScaleSection({
    required this.selectedPainLevel,
    required this.onPainLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.sentiment_satisfied_alt, color: AppColor.primary, size: 20),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pain Scale',
                    style: AppTextStyle.bodyText1.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Select pain level from 0 (No Pain) to 10 (Worst Pain)',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),

          /// PAIN LEVEL CIRCULAR EMOJI BUTTONS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(11, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < 10 ? 8.w : 0),
                  child: _PainLevelCircle(
                    level: index,
                    isSelected: selectedPainLevel == index,
                    onTap: () => onPainLevelSelected(index),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 16.h),

          /// GRADIENT SCALE BAR
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4CAF50), // Green
                  Color(0xFF8BC34A), // Light Green
                  Color(0xFFCDDC39), // Lime
                  Color(0xFFFFEB3B), // Yellow
                  Color(0xFFFFC107), // Amber
                  Color(0xFFFF9800), // Orange
                  Color(0xFFFF5722), // Deep Orange
                  Color(0xFFF44336), // Red
                ],
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),

          SizedBox(height: 12.h),

          /// SCALE LABELS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ScaleLabel(text: 'No Pain', align: TextAlign.left),
              _ScaleLabel(text: 'Mild', align: TextAlign.center),
              _ScaleLabel(text: 'Moderate', align: TextAlign.center),
              _ScaleLabel(text: 'Severe', align: TextAlign.center),
              _ScaleLabel(text: 'Worst Pain', align: TextAlign.right),
            ],
          ),
        ],
      ),
    );
  }
}

/// Scale label widget
class _ScaleLabel extends StatelessWidget {
  final String text;
  final TextAlign align;

  const _ScaleLabel({required this.text, required this.align});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9.sp,
          color: AppColor.secondaryText,
          fontWeight: FontWeight.w500,
        ),
        textAlign: align,
      ),
    );
  }
}

/// Circular pain level button with emoji
class _PainLevelCircle extends StatelessWidget {
  final int level;
  final bool isSelected;
  final VoidCallback onTap;

  const _PainLevelCircle({
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getPainColor(level);
    final emoji = _getPainEmoji(level);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          /// EMOJI CIRCLE
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? color : color.withOpacity(0.15),
              border: Border.all(
                color: isSelected ? color : color.withOpacity(0.5),
                width: isSelected ? 3 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: isSelected ? 26 : 22,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),

          /// NUMBER LABEL
          Container(
            width: 24.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Text(
                '$level',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColor.textOnPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPainEmoji(int level) {
    switch (level) {
      case 0:
        return '😀';
      case 1:
        return '😊';
      case 2:
        return '🙂';
      case 3:
        return '😌';
      case 4:
        return '😐';
      case 5:
        return '😕';
      case 6:
        return '😟';
      case 7:
        return '😣';
      case 8:
        return '😖';
      case 9:
        return '😫';
      case 10:
        return '😭';
      default:
        return '😐';
    }
  }

  Color _getPainColor(int level) {
    switch (level) {
      case 0:
        return const Color(0xFF4CAF50); // Green
      case 1:
        return const Color(0xFF66BB6A);
      case 2:
        return const Color(0xFF8BC34A); // Light Green
      case 3:
        return const Color(0xFFCDDC39); // Lime
      case 4:
        return const Color(0xFFFFEB3B); // Yellow
      case 5:
        return const Color(0xFFFFC107); // Amber
      case 6:
        return const Color(0xFFFF9800); // Orange
      case 7:
        return const Color(0xFFFF7043); // Deep Orange
      case 8:
        return const Color(0xFFFF5722); // Deep Orange
      case 9:
        return const Color(0xFFF44336); // Red
      case 10:
        return const Color(0xFFD32F2F); // Dark Red
      default:
        return const Color(0xFFFFC107);
    }
  }
}

/// Blood Pressure Section
class _BloodPressureSection extends StatelessWidget {
  final OpVitalsController controller;

  const _BloodPressureSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, color: AppColor.primary, size: 22),
              SizedBox(width: 8.w),
              Text('Blood Pressure', style: AppTextStyle.bodyText1.copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 20.h),
          _VitalsInputField(label: 'Lying', controller: controller.bpLyingController, unit: 'mmHg'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'Sitting', controller: controller.bpSittingController, unit: 'mmHg'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'Standing', controller: controller.bpStandingController, unit: 'mmHg'),
        ],
      ),
    );
  }
}

/// Heart & Respiratory Section
class _HeartRespiratorySection extends StatelessWidget {
  final OpVitalsController controller;

  const _HeartRespiratorySection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 22),
              SizedBox(width: 8.w),
              Expanded(child: Text('Heart & Respiratory Rate', style: AppTextStyle.bodyText1.copyWith(fontSize: 15, fontWeight: FontWeight.w600))),
            ],
          ),
          SizedBox(height: 20.h),
          _VitalsInputField(label: 'Pulse*', controller: controller.pulseController, unit: 'bpm'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'Respiratory Rate', controller: controller.respiratoryRateController, unit: '/min'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'SPO₂', controller: controller.spo2Controller, unit: '%'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'Temperature*', controller: controller.temperatureController, unit: '°F'),
        ],
      ),
    );
  }
}

/// Measurements Section
class _MeasurementsSection extends StatelessWidget {
  final OpVitalsController controller;

  const _MeasurementsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.containerOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.straighten, color: AppColor.primary, size: 22),
              SizedBox(width: 8.w),
              Text('Measurements', style: AppTextStyle.bodyText1.copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 20.h),
          _VitalsInputField(label: 'Blood Sugar', controller: controller.bloodSugarController, unit: 'mg/dl'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'Height', controller: controller.heightController, unit: 'cm'),
          SizedBox(height: 14.h),
          _VitalsInputField(label: 'Weight', controller: controller.weightController, unit: 'kg'),
        ],
      ),
    );
  }
}

/// Vitals input field widget
class _VitalsInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String unit;

  const _VitalsInputField({
    required this.label,
    required this.controller,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
          child: Text(label, style: AppTextStyle.bodyText2.copyWith(fontSize: 12)),
        ),
        Expanded(
          child: Container(
            height: 36.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEBF6FC),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFF59BBF0)),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter',
                hintStyle: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              style: AppTextStyle.bodyText2.copyWith(fontSize: 12),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(width: 45.w, child: Text(unit, style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 11))),
      ],
    );
  }
}
