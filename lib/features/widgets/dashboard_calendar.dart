import 'package:doctor/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DashboardCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DashboardCalendar> createState() => _DashboardCalendarState();
}

class _DashboardCalendarState extends State<DashboardCalendar> {
  late final PageController _pageController;
  late List<List<DateTime>> _weeks;
  int _currentPageIndex = 0;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _calculateDateRange();
    _generateWeeks();
    _currentPageIndex = _findWeekIndexForDate(widget.selectedDate);
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void didUpdateWidget(covariant DashboardCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      final newPageIndex = _findWeekIndexForDate(widget.selectedDate);
      if (newPageIndex != -1 && newPageIndex != _currentPageIndex) {
        _pageController.animateToPage(
          newPageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  /// Calculate the date range: 30 days in past, 365 days in future
  void _calculateDateRange() {
    final now = DateTime.now();
    _startDate = now.subtract(const Duration(days: 30));
    _endDate = now.add(const Duration(days: 365));
  }

  /// Generate weeks from start date to end date
  void _generateWeeks() {
    _weeks = [];
    DateTime currentWeekStart = _getStartOfWeek(_startDate);

    while (currentWeekStart.isBefore(_endDate) ||
        currentWeekStart.isAtSameMomentAs(_endDate)) {
      final week = List.generate(7, (i) {
        return currentWeekStart.add(Duration(days: i));
      });
      _weeks.add(week);
      currentWeekStart = currentWeekStart.add(const Duration(days: 7));
    }
  }

  /// Get the Sunday of the week containing the given date
  DateTime _getStartOfWeek(DateTime date) {
    // weekday: 1=Mon, 7=Sun
    final daysFromSunday = date.weekday % 7;
    return date.subtract(Duration(days: daysFromSunday));
  }

  /// Find which week page contains the given date
  int _findWeekIndexForDate(DateTime date) {
    for (int i = 0; i < _weeks.length; i++) {
      if (_weeks[i].any((d) => _isSameDay(d, date))) {
        return i;
      }
    }
    return 0;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.day == b.day && a.month == b.month && a.year == b.year;

  /// Check if a date is within the valid range
  bool _isDateInRange(DateTime date) {
    return (date.isAfter(_startDate) || _isSameDay(date, _startDate)) &&
        (date.isBefore(_endDate) || _isSameDay(date, _endDate));
  }

  /// Check if a date is in the past (before today)
  bool _isDateInPast(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    return compareDate.isBefore(today);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 90.h,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _weeks.length,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });

          // Auto-select the center date of the new week (Wednesday, index 3)
          final centerDate = _weeks[index][3];

          // Only select if it's in the valid range and not in the past
          if (_isDateInRange(centerDate) && !_isDateInPast(centerDate)) {
            widget.onDateSelected(centerDate);
          } else {
            // If center date is not valid, find the first valid date in the week
            final validDate = _weeks[index].firstWhere(
              (d) => _isDateInRange(d) && !_isDateInPast(d),
              orElse: () => centerDate,
            );
            if (!_isDateInPast(validDate)) {
              widget.onDateSelected(validDate);
            }
          }
        },
        itemBuilder: (context, weekIndex) {
          final week = _weeks[weekIndex];

          return Row(
            children: week.map((date) {
              final selected = _isSameDay(date, widget.selectedDate);
              final isInRange = _isDateInRange(date);
              final isPast = _isDateInPast(date);
              final isSelectable = isInRange && !isPast;

              return Expanded(
                child: GestureDetector(
                  onTap:
                      isSelectable ? () => widget.onDateSelected(date) : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _weekday(date.weekday),
                        style: AppTextStyle.bodyText2SubText.copyWith(
                          fontSize: 12.sp,
                          color: !isSelectable
                              ? colors.onSurface.withOpacity(0.3)
                              : null,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 40.w,
                        height: 40.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected ? colors.primary : Colors.transparent,
                        ),
                        child: Text(
                          '${date.day}',
                          style: AppTextStyle.bodyText1.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: selected
                                ? Colors.white
                                : !isSelectable
                                    ? colors.onSurface.withOpacity(0.3)
                                    : colors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  String _weekday(int day) =>
      const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day - 1];
}
