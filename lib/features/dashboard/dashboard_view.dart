import 'package:doctor/features/auth/logout/logout_controller.dart';
import 'package:doctor/features/widgets/assigned_patient_card.dart';
import 'package:doctor/features/widgets/dashboard_calendar.dart';
import 'package:doctor/features/widgets/profile_header.dart';
import 'package:doctor/features/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashboard_controller.dart';
import 'package:doctor/core/styles/text_styles.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutControllerProvider);

    final state = ref.watch(dashboardControllerProvider);
    final controller = ref.watch(dashboardControllerProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  ProfileHeader(
                    name: controller.userName,
                    greeting: controller.greeting,
                    onNotificationTap: controller.onNotificationTap,
                    onScanTap: controller.onScanTap,
                  ),

                  SizedBox(height: 24.h),

                  /// DATE
                  Text(
                    controller.formattedDate,
                    style: AppTextStyle.bodyText1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// CALENDAR
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: DashboardCalendar(
                      selectedDate: controller.selectedDate,
                      onDateSelected: controller.onDateSelected,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// ASSIGNED PATIENTS
                  AssignedPatientsCard(
                    completed: controller.completedPatients,
                    total: controller.totalPatients,
                  ),

                  SizedBox(height: 32.h),

                  Text(
                    "Today's Schedule",
                    style: AppTextStyle.bodyText1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  ...controller.schedules.map(
                    (s) => ScheduleCard(schedule: s),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (logoutState.isLoading)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
