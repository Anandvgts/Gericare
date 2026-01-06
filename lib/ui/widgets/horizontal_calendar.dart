import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/res/styles.dart';

class HorizontalCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const HorizontalCalendar({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  late ScrollController _scrollController;
  final double itemWidth = 56.0; // 50 width + 6 margin

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Scroll to center after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter();
    });
  }

  void _scrollToCenter() {
    if (!_scrollController.hasClients) return;

    // Calculate scroll position to center current date
    final screenWidth = MediaQuery.of(context).size.width;
    final centerOffset = (screenWidth / 2) - (itemWidth / 2);

    // Find today's index in the list
    final dates = _generateDates();
    final todayIndex = dates.indexWhere((date) =>
        date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year);

    if (todayIndex != -1) {
      // Position today's date at center
      final scrollPosition = (todayIndex * itemWidth) - centerOffset + 16;

      _scrollController.jumpTo(scrollPosition.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      ));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateDates() {
    final today = DateTime.now();
    final dates = <DateTime>[];

    // Generate dates: 30 days before today + today + 30 days after today = 61 days
    // This allows scrolling both backwards and forwards
    for (int i = -30; i <= 30; i++) {
      dates.add(today.add(Duration(days: i)));
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dates = _generateDates();

    return SizedBox(
      height: 90,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(), // Smooth scrolling
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.day == widget.selectedDate.day &&
              date.month == widget.selectedDate.month &&
              date.year == widget.selectedDate.year;

          final isToday = date.day == DateTime.now().day &&
              date.month == DateTime.now().month &&
              date.year == DateTime.now().year;

          return GestureDetector(
            onTap: () => widget.onDateSelected(date),
            child: Container(
              
              width: 50,
              margin: const EdgeInsets.only(right: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Weekday name
                  Text(
                    _getWeekdayName(date.weekday),
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date number with circle highlight
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected ? colors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${date.day}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isSelected ? Colors.white : colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekdays[weekday - 1];
  }
}
