import 'package:doctor/features/outpatient/data/op_models.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/services/api_requests/op_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_repository.g.dart';

@Riverpod(keepAlive: true)
class OpRepository extends _$OpRepository {
  final OpRequest _opRequest = OpRequest();

  @override
  build() => null;

  /// ========== CONSULTATIONS ==========

  /// Get ongoing consultations for a patient
  Future<List<OpConsultationModel>> getOngoingConsultations(String patientId) async {
    return apiBaseService.requestList<OpConsultationModel>(
      _opRequest.getOngoingConsultations(patientId),
      (data) {
        if (data is List) {
          return data.map((e) => OpConsultationModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Get past consultations for a patient
  Future<List<OpConsultationModel>> getPastConsultations(String patientId, {String? serviceType}) async {
    return apiBaseService.requestList<OpConsultationModel>(
      _opRequest.getPastConsultations(patientId, serviceType: serviceType),
      (data) {
        if (data is List) {
          return data.map((e) => OpConsultationModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Get consultation details
  Future<OpConsultationDetailModel> getConsultationDetail(String consultationId) async {
    return apiBaseService.request<OpConsultationDetailModel>(
      _opRequest.getConsultationDetail(consultationId),
      (data) => OpConsultationDetailModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Create new consultation
  Future<OpConsultationModel> createConsultation(Map<String, dynamic> data) async {
    return apiBaseService.request<OpConsultationModel>(
      _opRequest.createConsultation(data),
      (data) => OpConsultationModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Update consultation
  Future<OpConsultationModel> updateConsultation(String consultationId, Map<String, dynamic> data) async {
    return apiBaseService.request<OpConsultationModel>(
      _opRequest.updateConsultation(consultationId, data),
      (data) => OpConsultationModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Delete consultation
  Future<void> deleteConsultation(String consultationId) async {
    return apiBaseService.request<void>(
      _opRequest.deleteConsultation(consultationId),
      (_) {},
    );
  }

  /// Submit/Finalize consultation
  Future<void> submitConsultation(String consultationId) async {
    return apiBaseService.request<void>(
      _opRequest.submitConsultation(consultationId),
      (_) {},
    );
  }

  /// ========== VITALS ==========

  /// Get patient vitals
  Future<OpVitalsModel> getVitals(String consultationId) async {
    return apiBaseService.request<OpVitalsModel>(
      _opRequest.getVitals(consultationId),
      (data) => OpVitalsModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Save patient vitals
  Future<OpVitalsModel> saveVitals(String consultationId, Map<String, dynamic> data) async {
    return apiBaseService.request<OpVitalsModel>(
      _opRequest.saveVitals(consultationId, data),
      (data) => OpVitalsModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// ========== SYMPTOMS ==========

  /// Get symptoms master list
  Future<List<String>> getSymptomsList() async {
    return apiBaseService.requestList<String>(
      _opRequest.getSymptomsList(),
      (data) {
        if (data is List) {
          return data.map((e) => e['name'].toString()).toList();
        }
        return [];
      },
    );
  }

  /// Get consultation symptoms
  Future<List<OpSymptomModel>> getConsultationSymptoms(String consultationId) async {
    return apiBaseService.requestList<OpSymptomModel>(
      _opRequest.getConsultationSymptoms(consultationId),
      (data) {
        if (data is List) {
          return data.map((e) => OpSymptomModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation symptoms
  Future<void> saveSymptoms(String consultationId, List<Map<String, dynamic>> symptoms) async {
    return apiBaseService.request<void>(
      _opRequest.saveSymptoms(consultationId, symptoms),
      (_) {},
    );
  }

  /// ========== DIAGNOSIS ==========

  /// Get diagnosis master list
  Future<List<String>> getDiagnosisList() async {
    return apiBaseService.requestList<String>(
      _opRequest.getDiagnosisList(),
      (data) {
        if (data is List) {
          return data.map((e) => e['name'].toString()).toList();
        }
        return [];
      },
    );
  }

  /// Get consultation diagnosis
  Future<List<OpDiagnosisModel>> getConsultationDiagnosis(String consultationId) async {
    return apiBaseService.requestList<OpDiagnosisModel>(
      _opRequest.getConsultationDiagnosis(consultationId),
      (data) {
        if (data is List) {
          return data.map((e) => OpDiagnosisModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation diagnosis
  Future<void> saveDiagnosis(String consultationId, List<Map<String, dynamic>> diagnosis) async {
    return apiBaseService.request<void>(
      _opRequest.saveDiagnosis(consultationId, diagnosis),
      (_) {},
    );
  }

  /// ========== FINDINGS ==========

  /// Get findings master list
  Future<List<String>> getFindingsList() async {
    return apiBaseService.requestList<String>(
      _opRequest.getFindingsList(),
      (data) {
        if (data is List) {
          return data.map((e) => e['name'].toString()).toList();
        }
        return [];
      },
    );
  }

  /// Get consultation findings
  Future<List<OpFindingModel>> getConsultationFindings(String consultationId) async {
    return apiBaseService.requestList<OpFindingModel>(
      _opRequest.getConsultationFindings(consultationId),
      (data) {
        if (data is List) {
          return data.map((e) => OpFindingModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation findings
  Future<void> saveFindings(String consultationId, List<Map<String, dynamic>> findings) async {
    return apiBaseService.request<void>(
      _opRequest.saveFindings(consultationId, findings),
      (_) {},
    );
  }

  /// ========== MEDICINES ==========

  /// Get medicines master list
  Future<List<String>> getMedicinesList({String? search}) async {
    return apiBaseService.requestList<String>(
      _opRequest.getMedicinesList(search: search),
      (data) {
        if (data is List) {
          return data.map((e) => e['name'].toString()).toList();
        }
        return [];
      },
    );
  }

  /// Get consultation medicines
  Future<List<OpMedicineModel>> getConsultationMedicines(String consultationId) async {
    return apiBaseService.requestList<OpMedicineModel>(
      _opRequest.getConsultationMedicines(consultationId),
      (data) {
        if (data is List) {
          return data.map((e) => OpMedicineModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation medicines
  Future<void> saveMedicines(String consultationId, List<Map<String, dynamic>> medicines) async {
    return apiBaseService.request<void>(
      _opRequest.saveMedicines(consultationId, medicines),
      (_) {},
    );
  }

  /// ========== INVESTIGATIONS ==========

  /// Get investigations master list
  Future<List<OpInvestigationMasterModel>> getInvestigationsList({String? category}) async {
    return apiBaseService.requestList<OpInvestigationMasterModel>(
      _opRequest.getInvestigationsList(category: category),
      (data) {
        if (data is List) {
          return data.map((e) => OpInvestigationMasterModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation investigations
  Future<void> saveInvestigations(String consultationId, List<Map<String, dynamic>> investigations) async {
    return apiBaseService.request<void>(
      _opRequest.saveInvestigations(consultationId, investigations),
      (_) {},
    );
  }

  /// ========== INSTRUCTIONS ==========

  /// Get instructions master list
  Future<List<String>> getInstructionsList() async {
    return apiBaseService.requestList<String>(
      _opRequest.getInstructionsList(),
      (data) {
        if (data is List) {
          return data.map((e) => e['name'].toString()).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation instructions
  Future<void> saveInstructions(String consultationId, List<String> instructions) async {
    return apiBaseService.request<void>(
      _opRequest.saveInstructions(consultationId, instructions),
      (_) {},
    );
  }

  /// ========== PROCEDURES ==========

  /// Get procedures master list
  Future<List<String>> getProceduresList() async {
    return apiBaseService.requestList<String>(
      _opRequest.getProceduresList(),
      (data) {
        if (data is List) {
          return data.map((e) => e['name'].toString()).toList();
        }
        return [];
      },
    );
  }

  /// Save consultation procedures
  Future<void> saveProcedures(String consultationId, List<Map<String, dynamic>> procedures) async {
    return apiBaseService.request<void>(
      _opRequest.saveProcedures(consultationId, procedures),
      (_) {},
    );
  }

  /// ========== FOLLOW-UP ==========

  /// Save follow-up schedule
  Future<void> saveFollowup(String consultationId, Map<String, dynamic> data) async {
    return apiBaseService.request<void>(
      _opRequest.saveFollowup(consultationId, data),
      (_) {},
    );
  }

  /// ========== MEDICAL HISTORY ==========

  /// Get patient medical history
  Future<OpMedicalHistoryModel> getMedicalHistory(String patientId) async {
    return apiBaseService.request<OpMedicalHistoryModel>(
      _opRequest.getMedicalHistory(patientId),
      (data) => OpMedicalHistoryModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Save patient medical history
  Future<void> saveMedicalHistory(String patientId, Map<String, dynamic> data) async {
    return apiBaseService.request<void>(
      _opRequest.saveMedicalHistory(patientId, data),
      (_) {},
    );
  }

  /// ========== PATIENT ==========

  /// Get patient details
  Future<OpPatientModel> getPatientDetails(String patientId) async {
    return apiBaseService.request<OpPatientModel>(
      _opRequest.getPatientDetails(patientId),
      (data) => OpPatientModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Print patient sticker
  Future<void> printSticker(String patientId) async {
    return apiBaseService.request<void>(
      _opRequest.printSticker(patientId),
      (_) {},
    );
  }

  /// ========== AI SUMMARY ==========

  /// Get AI consultation summary
  Future<OpAISummaryModel> getAISummary(String consultationId) async {
    return apiBaseService.request<OpAISummaryModel>(
      _opRequest.getAISummary(consultationId),
      (data) => OpAISummaryModel.fromJson(data as Map<String, dynamic>),
    );
  }

  /// ========== PRESCRIPTION ==========

  /// Download prescription PDF
  Future<String> downloadPrescription(String consultationId) async {
    return apiBaseService.request<String>(
      _opRequest.downloadPrescription(consultationId),
      (data) => data['download_url'] as String? ?? '',
    );
  }

  /// Print prescription
  Future<void> printPrescription(String consultationId) async {
    return apiBaseService.request<void>(
      _opRequest.printPrescription(consultationId),
      (_) {},
    );
  }
}
