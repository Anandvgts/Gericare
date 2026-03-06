import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consultation_history_controller.g.dart';

/// Model for consultation history item
class ConsultationHistoryItem {
  final String id;
  final DateTime dateTime;
  final String doctorName;
  final String speciality;
  final String type; // 'Consultation', 'Follow-up', etc.
  final String summary;
  final List<String> symptoms;
  final List<String> diagnosis;
  final List<String> medicines;

  ConsultationHistoryItem({
    required this.id,
    required this.dateTime,
    required this.doctorName,
    required this.speciality,
    required this.type,
    required this.summary,
    this.symptoms = const [],
    this.diagnosis = const [],
    this.medicines = const [],
  });
}

@riverpod
class ConsultationHistoryController extends _$ConsultationHistoryController {
  String _patientId = '';

  List<ConsultationHistoryItem> _historyItems = [];
  List<ConsultationHistoryItem> get historyItems => _historyItems;

  /// Group history items by date
  Map<DateTime, List<ConsultationHistoryItem>> get groupedHistory {
    final Map<DateTime, List<ConsultationHistoryItem>> grouped = {};
    for (final item in _historyItems) {
      final dateKey = DateTime(item.dateTime.year, item.dateTime.month, item.dateTime.day);
      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(item);
    }
    // Sort by date descending
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return Map.fromEntries(sortedKeys.map((k) => MapEntry(k, grouped[k]!)));
  }

  DateTime get lastUpdated => _historyItems.isNotEmpty
      ? _historyItems.first.dateTime
      : DateTime.now();

  @override
  AsyncValue<void> build(String patientId) {
    _patientId = patientId;
    _loadDummyHistory();
    return const AsyncValue.data(null);
  }

  void _loadDummyHistory() {
    final now = DateTime.now();

    _historyItems = [
      // Today
      ConsultationHistoryItem(
        id: 'ch_001',
        dateTime: DateTime(now.year, now.month, now.day, 10, 30),
        doctorName: 'Dr. R. Magesh',
        speciality: 'Geriatrics',
        type: 'Consultation',
        summary: 'Follow-up for chronic conditions. Blood pressure stable.',
        symptoms: ['Mild fatigue', 'Joint pain'],
        diagnosis: ['Hypertension - controlled', 'Osteoarthritis'],
        medicines: ['Amlodipine 5mg', 'Paracetamol 500mg'],
      ),
      ConsultationHistoryItem(
        id: 'ch_002',
        dateTime: DateTime(now.year, now.month, now.day, 9, 0),
        doctorName: 'Dr. Priya Sharma',
        speciality: 'General Medicine',
        type: 'Routine Checkup',
        summary: 'Annual health checkup. All vitals normal.',
        symptoms: [],
        diagnosis: ['No acute issues'],
        medicines: [],
      ),

      // Yesterday
      ConsultationHistoryItem(
        id: 'ch_003',
        dateTime: DateTime(now.year, now.month, now.day - 1, 14, 0),
        doctorName: 'Dr. R. Magesh',
        speciality: 'Geriatrics',
        type: 'Follow-up',
        summary: 'Medication adjustment for better BP control.',
        symptoms: ['Dizziness', 'Headache'],
        diagnosis: ['Hypertension'],
        medicines: ['Amlodipine 10mg'],
      ),

      // Last week
      ConsultationHistoryItem(
        id: 'ch_004',
        dateTime: DateTime(now.year, now.month, now.day - 7, 11, 30),
        doctorName: 'Dr. Suresh Kumar',
        speciality: 'Cardiology',
        type: 'Specialist Consultation',
        summary: 'ECG normal. Continue current medications.',
        symptoms: ['Chest discomfort'],
        diagnosis: ['Stable angina'],
        medicines: ['Aspirin 75mg', 'Atorvastatin 20mg'],
      ),

      // 2 weeks ago
      ConsultationHistoryItem(
        id: 'ch_005',
        dateTime: DateTime(now.year, now.month, now.day - 14, 10, 0),
        doctorName: 'Dr. R. Magesh',
        speciality: 'Geriatrics',
        type: 'Consultation',
        summary: 'Initial assessment. Started on antihypertensives.',
        symptoms: ['High BP reading', 'Occasional headache'],
        diagnosis: ['Essential Hypertension'],
        medicines: ['Amlodipine 5mg'],
      ),
    ];
  }

  void openHistoryDetails(ConsultationHistoryItem item) {
    navigationService.pushNamed(
      Routes.consultationHistoryDetails,
      arguments: item,
    );
  }
}
