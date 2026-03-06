import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fluid_balance_controller.g.dart';

class FluidRow {
  final String time;
  final String nature;
  final String value;

  FluidRow({
    required this.time,
    required this.nature,
    required this.value,
  });
}

class FluidSection {
  final String title;
  final List<String> headers;
  final List<FluidRow> rows;

  FluidSection({
    required this.title,
    required this.headers,
    required this.rows,
  });
}

@riverpod
class FluidBalanceController extends _$FluidBalanceController {
  DateTime selectedDate = DateTime.now();

  /// Intake
  final List<FluidSection> intake = [];

  /// Output
  final List<FluidSection> output = [];

  @override
  AsyncValue<void> build() {
    _loadData();
    return const AsyncValue.data(null);
  }

  void _loadData() {
    intake.addAll([
      FluidSection(
        title: "Oral",
        headers: const ["Time", "Nature", "ML"],
        rows: [
          FluidRow(time: "8:35 AM", nature: "Food", value: "150 ml"),
          FluidRow(time: "9:40 AM", nature: "Curd", value: "100 ml"),
        ],
      ),
      FluidSection(
        title: "Ryle’s Tube Feeding",
        headers: const ["Time", "Nature", "ML"],
        rows: [
          FluidRow(time: "10:50 AM", nature: "H2O", value: "50 ml"),
        ],
      ),
    ]);

    output.addAll([
      FluidSection(
        title: "Urine",
        headers: const ["Time", "", "ML"],
        rows: [
          FluidRow(time: "8:35 AM", nature: "", value: "150 ml"),
        ],
      ),
      FluidSection(
        title: "Motion Passed",
        headers: const ["Time", "", "Times"],
        rows: [
          FluidRow(time: "10:50 AM", nature: "", value: "2"),
        ],
      ),
    ]);

    ref.notifyListeners();
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  String get formattedSelectedDate =>
      DateFormat("EEEE, d MMM").format(selectedDate);
}
