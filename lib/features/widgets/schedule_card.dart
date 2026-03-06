import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:doctor/core/enums/care_type.dart';
import 'package:doctor/features/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleCard extends StatelessWidget {
  final PatientSchedule schedule;
  final VoidCallback? onTap;

  const ScheduleCard({
    super.key,
    required this.schedule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _defaultNavigation(),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TIME SLOT
              if (schedule.timeSlot.isNotEmpty) ...[
                Text(
                  schedule.timeSlot,
                  style: AppTextStyle.bodyText2SubText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
              ],

              /// TAGS ROW
              Row(
                children: [
                  /// CARE TYPE TAG
                  _CareTypeTag(careType: schedule.careType),
                  SizedBox(width: 8.w),

                  /// PAYMENT STATUS TAG
                  _PaymentStatusTag(status: schedule.paymentStatus),

                  const Spacer(),

                  /// APPOINTMENT STATUS
                  _AppointmentStatusText(status: schedule.appointmentStatus),
                ],
              ),

              SizedBox(height: 12.h),

              /// PATIENT NAME
              Text(
                schedule.name,
                style: AppTextStyle.bodyText1.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 4.h),

              /// GENDER & AGE
              Text(
                '${schedule.gender}  .  ${schedule.age} Yrs',
                style: AppTextStyle.bodyText2SubText.copyWith(fontSize: 12),
              ),

              SizedBox(height: 12.h),

              /// SERVICE INFO CARD
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4DE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.medical_services_outlined,
                        size: 18,
                        color: const Color(0xFFEA9C00),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule.serviceName.isNotEmpty
                                ? schedule.serviceName
                                : 'Consultation',
                            style: AppTextStyle.bodyText2.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            schedule.centreName.isNotEmpty
                                ? schedule.centreName
                                : schedule.ward,
                            style: AppTextStyle.bodyText2SubText.copyWith(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// COMPLETED INDICATOR
              if (schedule.completed) ...[
                SizedBox(height: 10.h),
                _CompletedPill(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _defaultNavigation() {
    switch (schedule.careType) {
      case CareType.op:
        navigationService.pushNamed(
          Routes.opConsultation,
          arguments: schedule,
        );
        break;
      case CareType.al:
      case CareType.homeCare:
        navigationService.pushNamed(
          Routes.consultation,
          arguments: schedule.patientId,
        );
        break;
    }
  }
}

/// Care type tag widget
class _CareTypeTag extends StatelessWidget {
  final CareType careType;

  const _CareTypeTag({required this.careType});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (careType) {
      case CareType.op:
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        break;
      case CareType.al:
        bgColor = const Color(0xFF8B4789).withOpacity(0.12);
        textColor = const Color(0xFF8B4789);
        break;
      case CareType.homeCare:
        bgColor = context.colors.primary.withOpacity(0.12);
        textColor = context.colors.primary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        careType.label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

/// Payment status tag widget
class _PaymentStatusTag extends StatelessWidget {
  final PaymentStatus status;

  const _PaymentStatusTag({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case PaymentStatus.paid:
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF20C595);
        break;
      case PaymentStatus.pending:
        bgColor = const Color(0xFFFFF4DE);
        textColor = const Color(0xFFEA9C00);
        break;
      case PaymentStatus.unpaid:
        bgColor = const Color(0xFFFBE1EB);
        textColor = const Color(0xFFFF616D);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

/// Appointment status text widget
class _AppointmentStatusText extends StatelessWidget {
  final AppointmentStatus status;

  const _AppointmentStatusText({required this.status});

  @override
  Widget build(BuildContext context) {
    Color textColor;

    switch (status) {
      case AppointmentStatus.completed:
        textColor = const Color(0xFF20C595);
        break;
      case AppointmentStatus.inProgress:
        textColor = const Color(0xFF305EFF);
        break;
      case AppointmentStatus.cancelled:
        textColor = const Color(0xFFB4251E);
        break;
      case AppointmentStatus.upcoming:
        textColor = const Color(0xFF305EFF);
        break;
    }

    return Text(
      status.label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}

/// Completed pill widget
class _CompletedPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, size: 16, color: Color(0xFF4CAF50)),
          SizedBox(width: 6),
          Text(
            "Completed",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }
}
