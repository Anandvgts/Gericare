import 'package:gericare_doctor/core/base/base_view_model.dart';

class ConsultationHistoryItem {
  final String doctor;
  final String speciality;
  final String time;
  final String type;
  final DateTime date;

  ConsultationHistoryItem({
    required this.doctor,
    required this.speciality,
    required this.time,
    required this.type,
    required this.date,
  });
}

class ConsultationHistoryViewModel extends VGTSBaseViewModel {
  final List<ConsultationHistoryItem> history = [
    ConsultationHistoryItem(
      doctor: "Dr. John William",
      speciality: "Doctor - General Doctor",
      time: "8:10 AM",
      type: "Doctor - Consultation",
      date: DateTime(2025, 11, 7),
    ),
    ConsultationHistoryItem(
      doctor: "Dr. Dravid Kwel",
      speciality: "ENT",
      time: "12:35 PM",
      type: "Physiotherapy - Physio IFT",
      date: DateTime(2025, 11, 7),
    ),
    ConsultationHistoryItem(
      doctor: "Dr. Sam Richard",
      speciality: "Cardiology",
      time: "9:20 AM",
      type: "Heart - Heart Checkup",
      date: DateTime(2025, 11, 6),
    ),
    ConsultationHistoryItem(
      doctor: "Dr. Anita Roy",
      speciality: "Physician",
      time: "11:00 AM",
      type: "General - Consultation",
      date: DateTime(2025, 11, 4),
    ),
    ConsultationHistoryItem(
      doctor: "Dr. Alex John",
      speciality: "Orthopedic",
      time: "3:45 PM",
      type: "Artho - Joint Pain Review",
      date: DateTime(2025, 11, 2),
    ),
  ];

  void openDetails(ConsultationHistoryItem item) {
    navigationService.pushNamed(
      '/consultation-history-details',
      arguments: item,
    );
  }

  Map<DateTime, List<ConsultationHistoryItem>> get groupedHistory {
    final Map<DateTime, List<ConsultationHistoryItem>> map = {};

    for (final item in history) {
      final key = DateTime(item.date.year, item.date.month, item.date.day);
      map.putIfAbsent(key, () => []);
      map[key]!.add(item);
    }

    // Sort latest first
    return Map.fromEntries(
      map.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
  }
}
