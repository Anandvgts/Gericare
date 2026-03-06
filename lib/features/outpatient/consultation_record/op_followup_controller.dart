import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_followup_controller.g.dart';

@riverpod
class OpFollowupController extends _$OpFollowupController {
  final TextEditingController notesController = TextEditingController();

  String? _selectedQuickOption;
  String? get selectedQuickOption => _selectedQuickOption;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  bool _sendReminder = true;
  bool get sendReminder => _sendReminder;

  String _consultationId = '';

  bool get canSave => _selectedDate != null || _selectedQuickOption != null;

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    return const AsyncValue.data(null);
  }

  void selectQuickOption(String option) {
    _selectedQuickOption = option;
    _selectedDate = _calculateDateFromOption(option);
    ref.notifyListeners();
  }

  DateTime _calculateDateFromOption(String option) {
    final now = DateTime.now();
    switch (option) {
      case '1 Week':
        return now.add(const Duration(days: 7));
      case '2 Weeks':
        return now.add(const Duration(days: 14));
      case '1 Month':
        return DateTime(now.year, now.month + 1, now.day);
      case '2 Months':
        return DateTime(now.year, now.month + 2, now.day);
      case '3 Months':
        return DateTime(now.year, now.month + 3, now.day);
      case '6 Months':
        return DateTime(now.year, now.month + 6, now.day);
      default:
        return now.add(const Duration(days: 7));
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      _selectedDate = date;
      _selectedQuickOption = null;
      ref.notifyListeners();
    }
  }

  void toggleReminder(bool value) {
    _sendReminder = value;
    ref.notifyListeners();
  }

  void onSaveFollowup() {
    // TODO: Save follow-up to API when ready
    debugPrint('Saving follow-up: Date: $_selectedDate, Notes: ${notesController.text}, Reminder: $_sendReminder');
    navigationService.pop();
  }
}
