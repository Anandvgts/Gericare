import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';
import 'package:gericare_doctor/ui/widgets/horizontal_calendar.dart';
import 'package:gericare_doctor/ui/widgets/icon_button.dart';
import 'package:stacked/stacked.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: colors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    children: [
                      /// PROFILE IMAGE
                      CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            const AssetImage('assets/main/ch_profile.png'),
                      ),

                      const SizedBox(width: 12),

                      /// NAME + GREETING
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Priya Nair",
                              style: AppTextStyle.title1Bold
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Good Morning !",
                              style: AppTextStyle.bodyText2SubText
                                  .copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ),

                      /// NOTIFICATION BUTTON
                      IconButtonWidget(
                        icon: Icons.notifications_none_outlined,
                        onTap: viewModel.onNotificationTap,
                      ),

                      const SizedBox(width: 8),

                      /// SCANNER BUTTON
                      IconButtonWidget(
                        icon: Icons.qr_code_scanner_outlined,
                        onTap: () => viewModel.onScanTap(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// DATE TITLE
                  Text(
                    viewModel.getFormattedDate(),
                    style: AppTextStyle.title1Bold.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// CALENDAR
                  HorizontalCalendar(
                    selectedDate: viewModel.selectedDate,
                    onDateSelected: viewModel.onDateSelected,
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assigned Patients",
                          style: AppTextStyle.title1Bold.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// Dashed Progress Bar
                        AssignedPatientsProgressBar(
                          completed: viewModel.completedPatients,
                          total: viewModel.totalPatients,
                          activeColor: colors.onSecondary,
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Text(
                              "${viewModel.completedPatients}/${viewModel.totalPatients} ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colors.onSurface,
                              ),
                            ),
                            Text(
                              "Patients",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: colors.onSurface.withOpacity(0.6),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${viewModel.getCompletionPercentage()} %",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// TODAY SCHEDULE
                  Text(
                    "Today's Schedule",
                    style: AppTextStyle.title1Bold.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Schedule Cards
                  ...viewModel.schedules.map((schedule) {
                    return _ScheduleCard(
                      name: schedule.name,
                      ward: schedule.ward,
                      completed: schedule.completed,
                      colors: colors,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SlantedPillClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double cut = size.height * 0.8;

    return Path()
      ..moveTo(cut, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - cut, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AssignedPatientsProgressBar extends StatelessWidget {
  final int completed;
  final int total;
  final Color activeColor;

  const AssignedPatientsProgressBar({
    super.key,
    required this.completed,
    required this.total,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    const int segments = 20;
   final filled = total == 0
    ? 0
    : ((completed / total) * segments).round();

    return LayoutBuilder(
      builder: (context, constraints) {
        // const double gap = 1;
        final double pillWidth = (constraints.maxWidth - (segments)) / segments;

        return SizedBox(
          height: 16,
          width: double.infinity,
          child: Row(
            children: List.generate(segments, (index) {
              final isActive = index < filled;

              return Padding(
                padding:
                    EdgeInsets.only(right: index == segments - 1 ? 0 : 0.1),
                child: ClipPath(
                  clipper: SlantedPillClipper(),
                  child: Container(
                    width: pillWidth,
                    height: 10,
                    color: isActive ? activeColor : const Color(0xFFE6E9ED),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final String name;
  final String ward;
  final bool completed;
  final ColorScheme colors;

  const _ScheduleCard({
    required this.name,
    required this.ward,
    required this.completed,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: completed
        //     ? const Color(0xFFEFF8F1) // 🔥 light green bg
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// CATEGORY CHIP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF8B4789).withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Assisted Living",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8B4789),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// NAME
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          /// WARD
          Text(
            ward,
            style: TextStyle(
              fontSize: 14,
              color: colors.onSurface.withOpacity(0.6),
            ),
          ),

          if (completed) ...[
            const SizedBox(height: 12),

            /// COMPLETED PILL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Color(0xFF4CAF50),
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Completed",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
