// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final alNeedAssessmentViewModelProvider =
//     ChangeNotifierProvider.family<AlNeedAssessmentViewModel, String>(
//   (ref, patientId) => AlNeedAssessmentViewModel(patientId),
// );

// class InfoRowData {
//   final String label;
//   final String value;

//   InfoRowData(this.label, this.value);
// }

// class AlNeedAssessmentViewModel extends ChangeNotifier {
//   final String patientId;

//   AlNeedAssessmentViewModel(this.patientId) {
//     _loadData();
//   }

//   String patientName = "Mr. Krishna Kumar";
//   String gender = "Male";
//   int age = 74;

//   List<InfoRowData> callerDetails = [];
//   List<InfoRowData> functionalStatus = [];
//   List<InfoRowData> assessmentForms = [];

//   void _loadData() {
//     callerDetails = [
//       InfoRowData("Caller Name", "Arun Kumar"),
//       InfoRowData("Location", "T Nagar"),
//       InfoRowData("UHID", "#987654"),
//       InfoRowData("Lead ID", "0938754"),
//       InfoRowData("Preferred Location", "RA Puram"),
//       InfoRowData("Patient Name", "Kishore Nayak"),
//       InfoRowData("Current Location", "RA Puram"),
//       InfoRowData("Stay Type", "Long Stay (>1 month)"),
//       InfoRowData("Current Ailments", "--"),
//       InfoRowData("Stay Requirements", "Couple Stay"),
//       InfoRowData("Date of Site Visit", "20/05/2025"),
//       InfoRowData("Admission Planned On", "30/05/2025"),
//       InfoRowData("Agreed Tariff", "--"),
//     ];

//     functionalStatus = [
//       InfoRowData("Bathing and Dressing", "Minimal Assistance"),
//       InfoRowData("Toileting", "Minimal Assistance"),
//       InfoRowData("Transferring", "Self"),
//       InfoRowData("Continence", "Self"),
//       InfoRowData("Feeding", "Self"),
//       InfoRowData("Ambulation Support", "No"),
//       InfoRowData("Medications", "Minimal Assistance"),
//       InfoRowData("Airway", "Minimal Assistance"),
//     ];

//     assessmentForms = [
//       InfoRowData(
//         "Clinical Forms",
//         "Clinical Frailty Scale, Grip Test, Mini COG, MOCA",
//       ),
//       InfoRowData(
//         "Non-Clinical Forms",
//         "GCS Score, Early warning score",
//       ),
//     ];

//     notifyListeners();
//   }
// }



import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'al_need_assessment_controller.g.dart';

class InfoRowData {
  final String label;
  final String value;

  InfoRowData(this.label, this.value);
}

@riverpod
class AlNeedAssessmentController extends _$AlNeedAssessmentController {
  late final String patientId;

  /// Patient info
  String patientName = "";
  String gender = "";
  int age = 0;

  /// Sections
  List<InfoRowData> callerDetails = [];
  List<InfoRowData> functionalStatus = [];
  List<InfoRowData> assessmentForms = [];

  @override
  AsyncValue<void> build(String patientId) {

    _loadData(patientId);
    return const AsyncValue.data(null);
  }

  void _loadData(String patientId) {
    /// TEMP DATA (replace with API later)
    patientName = "Mr. Krishna Kumar";
    gender = "Male";
    age = 74;

    callerDetails = [
      InfoRowData("Caller Name", "Arun Kumar"),
      InfoRowData("Location", "T Nagar"),
      InfoRowData("UHID", "#987654"),
      InfoRowData("Lead ID", "0938754"),
      InfoRowData("Preferred Location", "RA Puram"),
      InfoRowData("Patient Name", "Kishore Nayak"),
      InfoRowData("Current Location", "RA Puram"),
      InfoRowData("Stay Type", "Long Stay (>1 month)"),
      InfoRowData("Current Ailments", "--"),
      InfoRowData("Stay Requirements", "Couple Stay"),
      InfoRowData("Date of Site Visit", "20/05/2025"),
      InfoRowData("Admission Planned On", "30/05/2025"),
      InfoRowData("Agreed Tariff", "--"),
    ];

    functionalStatus = [
      InfoRowData("Bathing and Dressing", "Minimal Assistance"),
      InfoRowData("Toileting", "Minimal Assistance"),
      InfoRowData("Transferring", "Self"),
      InfoRowData("Continence", "Self"),
      InfoRowData("Feeding", "Self"),
      InfoRowData("Ambulation Support", "No"),
      InfoRowData("Medications", "Minimal Assistance"),
      InfoRowData("Airway", "Minimal Assistance"),
    ];

    assessmentForms = [
      InfoRowData(
        "Clinical Forms",
        "Clinical Frailty Scale, Grip Test, Mini COG, MOCA",
      ),
      InfoRowData(
        "Non-Clinical Forms",
        "GCS Score, Early warning score",
      ),
    ];

    /// Rebuild UI
    ref.notifyListeners();
  }
}
