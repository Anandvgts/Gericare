import 'package:doctor/core/enums/request_method.dart';
import 'package:doctor/core/models/request_settings.dart';

class OpRequest {
  /// ========== CONSULTATION ENDPOINTS ==========

  /// Get ongoing consultations for a patient
  /// Endpoint: /op/mobile/v1/consultations/ongoing/{patient_id}/
  RequestSettings getOngoingConsultations(String patientId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/ongoing/$patientId/",
      authenticated: true,
    );
  }

  /// Get past consultations for a patient
  /// Endpoint: /op/mobile/v1/consultations/past/{patient_id}/
  RequestSettings getPastConsultations(String patientId, {String? serviceType}) {
    String endpoint = "/op/mobile/v1/consultations/past/$patientId/";
    if (serviceType != null && serviceType != 'all') {
      endpoint += "?service_type=$serviceType";
    }
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: endpoint,
      authenticated: true,
    );
  }

  /// Get consultation details
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/
  RequestSettings getConsultationDetail(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/",
      authenticated: true,
    );
  }

  /// Create new consultation
  /// Endpoint: /op/mobile/v1/consultations/
  RequestSettings createConsultation(Map<String, dynamic> data) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/",
      params: data,
      authenticated: true,
    );
  }

  /// Update consultation
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/
  RequestSettings updateConsultation(String consultationId, Map<String, dynamic> data) {
    return RequestSettings(
      method: RequestMethod.PUT,
      endPoint: "/op/mobile/v1/consultations/$consultationId/",
      params: data,
      authenticated: true,
    );
  }

  /// Delete consultation
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/
  RequestSettings deleteConsultation(String consultationId) {
    return RequestSettings(
      method: RequestMethod.DELETE,
      endPoint: "/op/mobile/v1/consultations/$consultationId/",
      authenticated: true,
    );
  }

  /// ========== VITALS ENDPOINTS ==========

  /// Get patient vitals
  /// Endpoint: /op/mobile/v1/vitals/{consultation_id}/
  RequestSettings getVitals(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/vitals/$consultationId/",
      authenticated: true,
    );
  }

  /// Save patient vitals
  /// Endpoint: /op/mobile/v1/vitals/{consultation_id}/
  RequestSettings saveVitals(String consultationId, Map<String, dynamic> data) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/vitals/$consultationId/",
      params: data,
      authenticated: true,
    );
  }

  /// ========== SYMPTOMS ENDPOINTS ==========

  /// Get symptoms list (master data)
  /// Endpoint: /op/mobile/v1/symptoms/
  RequestSettings getSymptomsList() {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/symptoms/",
      authenticated: true,
    );
  }

  /// Get patient symptoms for a consultation
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/symptoms/
  RequestSettings getConsultationSymptoms(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/symptoms/",
      authenticated: true,
    );
  }

  /// Save patient symptoms
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/symptoms/
  RequestSettings saveSymptoms(String consultationId, List<Map<String, dynamic>> symptoms) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/symptoms/",
      params: {"symptoms": symptoms},
      authenticated: true,
    );
  }

  /// ========== DIAGNOSIS ENDPOINTS ==========

  /// Get diagnosis list (master data)
  /// Endpoint: /op/mobile/v1/diagnosis/
  RequestSettings getDiagnosisList() {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/diagnosis/",
      authenticated: true,
    );
  }

  /// Get consultation diagnosis
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/diagnosis/
  RequestSettings getConsultationDiagnosis(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/diagnosis/",
      authenticated: true,
    );
  }

  /// Save consultation diagnosis
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/diagnosis/
  RequestSettings saveDiagnosis(String consultationId, List<Map<String, dynamic>> diagnosis) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/diagnosis/",
      params: {"diagnosis": diagnosis},
      authenticated: true,
    );
  }

  /// ========== FINDINGS ENDPOINTS ==========

  /// Get findings list (master data)
  /// Endpoint: /op/mobile/v1/findings/
  RequestSettings getFindingsList() {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/findings/",
      authenticated: true,
    );
  }

  /// Get consultation findings
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/findings/
  RequestSettings getConsultationFindings(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/findings/",
      authenticated: true,
    );
  }

  /// Save consultation findings
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/findings/
  RequestSettings saveFindings(String consultationId, List<Map<String, dynamic>> findings) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/findings/",
      params: {"findings": findings},
      authenticated: true,
    );
  }

  /// ========== MEDICINES ENDPOINTS ==========

  /// Get medicines list (master data)
  /// Endpoint: /op/mobile/v1/medicines/
  RequestSettings getMedicinesList({String? search}) {
    String endpoint = "/op/mobile/v1/medicines/";
    if (search != null && search.isNotEmpty) {
      endpoint += "?search=$search";
    }
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: endpoint,
      authenticated: true,
    );
  }

  /// Get consultation medicines (prescription)
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/medicines/
  RequestSettings getConsultationMedicines(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/medicines/",
      authenticated: true,
    );
  }

  /// Save consultation medicines (prescription)
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/medicines/
  RequestSettings saveMedicines(String consultationId, List<Map<String, dynamic>> medicines) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/medicines/",
      params: {"medicines": medicines},
      authenticated: true,
    );
  }

  /// ========== INVESTIGATIONS ENDPOINTS ==========

  /// Get investigations list (master data)
  /// Endpoint: /op/mobile/v1/investigations/
  RequestSettings getInvestigationsList({String? category}) {
    String endpoint = "/op/mobile/v1/investigations/";
    if (category != null && category != 'All') {
      endpoint += "?category=$category";
    }
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: endpoint,
      authenticated: true,
    );
  }

  /// Get consultation investigations
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/investigations/
  RequestSettings getConsultationInvestigations(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/investigations/",
      authenticated: true,
    );
  }

  /// Save consultation investigations
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/investigations/
  RequestSettings saveInvestigations(String consultationId, List<Map<String, dynamic>> investigations) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/investigations/",
      params: {"investigations": investigations},
      authenticated: true,
    );
  }

  /// ========== INSTRUCTIONS ENDPOINTS ==========

  /// Get instructions list (master data)
  /// Endpoint: /op/mobile/v1/instructions/
  RequestSettings getInstructionsList() {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/instructions/",
      authenticated: true,
    );
  }

  /// Save consultation instructions
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/instructions/
  RequestSettings saveInstructions(String consultationId, List<String> instructions) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/instructions/",
      params: {"instructions": instructions},
      authenticated: true,
    );
  }

  /// ========== PROCEDURES ENDPOINTS ==========

  /// Get procedures list (master data)
  /// Endpoint: /op/mobile/v1/procedures/
  RequestSettings getProceduresList() {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/procedures/",
      authenticated: true,
    );
  }

  /// Save consultation procedures
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/procedures/
  RequestSettings saveProcedures(String consultationId, List<Map<String, dynamic>> procedures) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/procedures/",
      params: {"procedures": procedures},
      authenticated: true,
    );
  }

  /// ========== FOLLOW-UP ENDPOINTS ==========

  /// Save follow-up schedule
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/followup/
  RequestSettings saveFollowup(String consultationId, Map<String, dynamic> data) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/followup/",
      params: data,
      authenticated: true,
    );
  }

  /// ========== MEDICAL HISTORY ENDPOINTS ==========

  /// Get patient medical history
  /// Endpoint: /op/mobile/v1/patients/{patient_id}/medical-history/
  RequestSettings getMedicalHistory(String patientId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/patients/$patientId/medical-history/",
      authenticated: true,
    );
  }

  /// Save patient medical history
  /// Endpoint: /op/mobile/v1/patients/{patient_id}/medical-history/
  RequestSettings saveMedicalHistory(String patientId, Map<String, dynamic> data) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/patients/$patientId/medical-history/",
      params: data,
      authenticated: true,
    );
  }

  /// ========== PATIENT ENDPOINTS ==========

  /// Get patient details
  /// Endpoint: /op/mobile/v1/patients/{patient_id}/
  RequestSettings getPatientDetails(String patientId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/patients/$patientId/",
      authenticated: true,
    );
  }

  /// Print patient sticker
  /// Endpoint: /op/mobile/v1/patients/{patient_id}/print-sticker/
  RequestSettings printSticker(String patientId) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/patients/$patientId/print-sticker/",
      authenticated: true,
    );
  }

  /// ========== AI SUMMARY ENDPOINTS ==========

  /// Get AI consultation summary
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/ai-summary/
  RequestSettings getAISummary(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/ai-summary/",
      authenticated: true,
    );
  }

  /// ========== PRESCRIPTION ENDPOINTS ==========

  /// Download prescription PDF
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/prescription/download/
  RequestSettings downloadPrescription(String consultationId) {
    return RequestSettings(
      method: RequestMethod.GET,
      endPoint: "/op/mobile/v1/consultations/$consultationId/prescription/download/",
      authenticated: true,
    );
  }

  /// Print prescription
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/prescription/print/
  RequestSettings printPrescription(String consultationId) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/prescription/print/",
      authenticated: true,
    );
  }

  /// Save/Submit consultation (finalize)
  /// Endpoint: /op/mobile/v1/consultations/{consultation_id}/submit/
  RequestSettings submitConsultation(String consultationId) {
    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/op/mobile/v1/consultations/$consultationId/submit/",
      authenticated: true,
    );
  }
}
