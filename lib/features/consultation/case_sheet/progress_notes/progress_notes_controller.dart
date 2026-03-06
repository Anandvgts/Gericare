import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_notes_controller.g.dart';

class ProgressNote {
  final String name;
  final DateTime dateTime;
  final String note;
  final String avatar;

  ProgressNote({
    required this.name,
    required this.dateTime,
    required this.note,
    required this.avatar,
  });
}

@riverpod
class ProgressNotesController extends _$ProgressNotesController {
  DateTime selectedDate = DateTime.now();
  final List<ProgressNote> notes = [];

  @override
  AsyncValue<void> build() {
    _loadNotes();
    return const AsyncValue.data(null);
  }

  void _loadNotes() {
    notes.addAll([
      ProgressNote(
        name: "Priya Nair",
        dateTime: DateTime.now().copyWith(hour: 10, minute: 30),
        note: "Patient received all the tablets and care.",
        avatar: "assets/main/ch_profile.png",
      ),
      ProgressNote(
        name: "Priya Nair",
        dateTime: DateTime.now().copyWith(hour: 13, minute: 30),
        note:
            "Patient position changed after 2 hours, and woke up after 1 hour.",
        avatar: "assets/main/ch_profile.png",
      ),
      ProgressNote(
        name: "Vinay Kumar",
        dateTime: DateTime.now().copyWith(hour: 16, minute: 30),
        note:
            "Patient position changed after 2 hours, and woke up after 1 hour.",
        avatar: "assets/main/ch_profile.png",
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

  String formatTime(DateTime dateTime) =>
      DateFormat("h:mm a").format(dateTime);
}
