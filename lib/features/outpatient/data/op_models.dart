// ========== CONSULTATION MODELS ==========

class OpConsultationModel {
  final String id;
  final int? serialNo;
  final String? encounterId;
  final String? doctorName;
  final String? department;
  final String? serviceName;
  final String? serviceCategory;
  final String? dateTime;
  final String? status;
  final String? paymentStatus;
  final String? patientId;
  final bool isDue;

  OpConsultationModel({
    required this.id,
    this.serialNo,
    this.encounterId,
    this.doctorName,
    this.department,
    this.serviceName,
    this.serviceCategory,
    this.dateTime,
    this.status,
    this.paymentStatus,
    this.patientId,
    this.isDue = false,
  });

  factory OpConsultationModel.fromJson(Map<String, dynamic> json) {
    return OpConsultationModel(
      id: json['id']?.toString() ?? '',
      serialNo: json['serial_no'],
      encounterId: json['encounter_id'],
      doctorName: json['doctor_name'],
      department: json['department'],
      serviceName: json['service_name'],
      serviceCategory: json['service_category'],
      dateTime: json['date_time'],
      status: json['status'],
      paymentStatus: json['payment_status'],
      patientId: json['patient_id']?.toString(),
      isDue: json['is_due'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serial_no': serialNo,
      'encounter_id': encounterId,
      'doctor_name': doctorName,
      'department': department,
      'service_name': serviceName,
      'service_category': serviceCategory,
      'date_time': dateTime,
      'status': status,
      'payment_status': paymentStatus,
      'patient_id': patientId,
      'is_due': isDue,
    };
  }
}

class OpConsultationDetailModel {
  final String id;
  final String encounterId;
  final OpPatientModel patient;
  final String doctorName;
  final String department;
  final String serviceName;
  final String dateTime;
  final String status;
  final OpVitalsModel? vitals;
  final List<OpSymptomModel> symptoms;
  final List<OpDiagnosisModel> diagnosis;
  final List<OpFindingModel> findings;
  final List<OpMedicineModel> medicines;
  final List<OpInvestigationModel> investigations;
  final List<String> instructions;
  final List<OpProcedureModel> procedures;
  final OpFollowupModel? followup;

  OpConsultationDetailModel({
    required this.id,
    required this.encounterId,
    required this.patient,
    required this.doctorName,
    required this.department,
    required this.serviceName,
    required this.dateTime,
    required this.status,
    this.vitals,
    this.symptoms = const [],
    this.diagnosis = const [],
    this.findings = const [],
    this.medicines = const [],
    this.investigations = const [],
    this.instructions = const [],
    this.procedures = const [],
    this.followup,
  });

  factory OpConsultationDetailModel.fromJson(Map<String, dynamic> json) {
    return OpConsultationDetailModel(
      id: json['id']?.toString() ?? '',
      encounterId: json['encounter_id'] ?? '',
      patient: OpPatientModel.fromJson(json['patient'] ?? {}),
      doctorName: json['doctor_name'] ?? '',
      department: json['department'] ?? '',
      serviceName: json['service_name'] ?? '',
      dateTime: json['date_time'] ?? '',
      status: json['status'] ?? '',
      vitals: json['vitals'] != null ? OpVitalsModel.fromJson(json['vitals']) : null,
      symptoms: (json['symptoms'] as List?)?.map((e) => OpSymptomModel.fromJson(e)).toList() ?? [],
      diagnosis: (json['diagnosis'] as List?)?.map((e) => OpDiagnosisModel.fromJson(e)).toList() ?? [],
      findings: (json['findings'] as List?)?.map((e) => OpFindingModel.fromJson(e)).toList() ?? [],
      medicines: (json['medicines'] as List?)?.map((e) => OpMedicineModel.fromJson(e)).toList() ?? [],
      investigations: (json['investigations'] as List?)?.map((e) => OpInvestigationModel.fromJson(e)).toList() ?? [],
      instructions: (json['instructions'] as List?)?.map((e) => e.toString()).toList() ?? [],
      procedures: (json['procedures'] as List?)?.map((e) => OpProcedureModel.fromJson(e)).toList() ?? [],
      followup: json['followup'] != null ? OpFollowupModel.fromJson(json['followup']) : null,
    );
  }
}

/// ========== PATIENT MODEL ==========

class OpPatientModel {
  final String id;
  final String name;
  final String uhid;
  final String gender;
  final int age;
  final String? dob;
  final String? phone;
  final String? email;
  final String? address;

  OpPatientModel({
    required this.id,
    required this.name,
    required this.uhid,
    required this.gender,
    required this.age,
    this.dob,
    this.phone,
    this.email,
    this.address,
  });

  factory OpPatientModel.fromJson(Map<String, dynamic> json) {
    return OpPatientModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      uhid: json['uhid'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? 0,
      dob: json['dob'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uhid': uhid,
      'gender': gender,
      'age': age,
      'dob': dob,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}

/// ========== VITALS MODEL ==========

class OpVitalsModel {
  final int? painLevel;
  final String? bpLying;
  final String? bpSitting;
  final String? bpStanding;
  final String? pulse;
  final String? respiratoryRate;
  final String? spo2;
  final String? temperature;
  final String? bloodSugar;
  final String? height;
  final String? weight;

  OpVitalsModel({
    this.painLevel,
    this.bpLying,
    this.bpSitting,
    this.bpStanding,
    this.pulse,
    this.respiratoryRate,
    this.spo2,
    this.temperature,
    this.bloodSugar,
    this.height,
    this.weight,
  });

  factory OpVitalsModel.fromJson(Map<String, dynamic> json) {
    return OpVitalsModel(
      painLevel: json['pain_level'],
      bpLying: json['bp_lying'],
      bpSitting: json['bp_sitting'],
      bpStanding: json['bp_standing'],
      pulse: json['pulse'],
      respiratoryRate: json['respiratory_rate'],
      spo2: json['spo2'],
      temperature: json['temperature'],
      bloodSugar: json['blood_sugar'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pain_level': painLevel,
      'bp_lying': bpLying,
      'bp_sitting': bpSitting,
      'bp_standing': bpStanding,
      'pulse': pulse,
      'respiratory_rate': respiratoryRate,
      'spo2': spo2,
      'temperature': temperature,
      'blood_sugar': bloodSugar,
      'height': height,
      'weight': weight,
    };
  }

  bool get isComplete => pulse != null && temperature != null;
}

/// ========== SYMPTOM MODEL ==========

class OpSymptomModel {
  final String name;
  final String? since;
  final String? severity;

  OpSymptomModel({
    required this.name,
    this.since,
    this.severity,
  });

  factory OpSymptomModel.fromJson(Map<String, dynamic> json) {
    return OpSymptomModel(
      name: json['name'] ?? '',
      since: json['since'],
      severity: json['severity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'since': since,
      'severity': severity,
    };
  }

  bool get isComplete => since != null && severity != null;
}

/// ========== DIAGNOSIS MODEL ==========

class OpDiagnosisModel {
  final String name;
  final String? since;
  final String? location;
  final String? treatmentStatus;

  OpDiagnosisModel({
    required this.name,
    this.since,
    this.location,
    this.treatmentStatus,
  });

  factory OpDiagnosisModel.fromJson(Map<String, dynamic> json) {
    return OpDiagnosisModel(
      name: json['name'] ?? '',
      since: json['since'],
      location: json['location'],
      treatmentStatus: json['treatment_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'since': since,
      'location': location,
      'treatment_status': treatmentStatus,
    };
  }
}

/// ========== FINDING MODEL ==========

class OpFindingModel {
  final String name;
  final String? notes;
  final String? duration;
  final String? severity;

  OpFindingModel({
    required this.name,
    this.notes,
    this.duration,
    this.severity,
  });

  factory OpFindingModel.fromJson(Map<String, dynamic> json) {
    return OpFindingModel(
      name: json['name'] ?? '',
      notes: json['notes'],
      duration: json['duration'],
      severity: json['severity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'duration': duration,
      'severity': severity,
    };
  }

  bool get isComplete => duration != null && severity != null;
}

/// ========== MEDICINE MODEL ==========

class OpMedicineModel {
  final String name;
  final String type; // tablet, syrup, injection, capsule
  final double quantity;
  final String frequency;
  final String intake;
  final String duration;
  final String? notes;
  final double morningQty;
  final double noonQty;
  final double nightQty;

  OpMedicineModel({
    required this.name,
    this.type = 'tablet',
    this.quantity = 1,
    this.frequency = 'Once',
    this.intake = 'After Food',
    this.duration = '1 Week',
    this.notes,
    this.morningQty = 0,
    this.noonQty = 0,
    this.nightQty = 0,
  });

  factory OpMedicineModel.fromJson(Map<String, dynamic> json) {
    return OpMedicineModel(
      name: json['name'] ?? '',
      type: json['type'] ?? 'tablet',
      quantity: (json['quantity'] ?? 1).toDouble(),
      frequency: json['frequency'] ?? 'Once',
      intake: json['intake'] ?? 'After Food',
      duration: json['duration'] ?? '1 Week',
      notes: json['notes'],
      morningQty: (json['morning_qty'] ?? 0).toDouble(),
      noonQty: (json['noon_qty'] ?? 0).toDouble(),
      nightQty: (json['night_qty'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'quantity': quantity,
      'frequency': frequency,
      'intake': intake,
      'duration': duration,
      'notes': notes,
      'morning_qty': morningQty,
      'noon_qty': noonQty,
      'night_qty': nightQty,
    };
  }

  String get dosageSummary {
    if (morningQty > 0 || noonQty > 0 || nightQty > 0) {
      return '${morningQty.toInt()}-${noonQty.toInt()}-${nightQty.toInt()}';
    }
    return '$frequency, $intake';
  }
}

/// ========== INVESTIGATION MODEL ==========

class OpInvestigationModel {
  final String name;
  final String? urgency;
  final String? notes;

  OpInvestigationModel({
    required this.name,
    this.urgency = 'Routine',
    this.notes,
  });

  factory OpInvestigationModel.fromJson(Map<String, dynamic> json) {
    return OpInvestigationModel(
      name: json['name'] ?? '',
      urgency: json['urgency'] ?? 'Routine',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'urgency': urgency,
      'notes': notes,
    };
  }
}

class OpInvestigationMasterModel {
  final String name;
  final String category;

  OpInvestigationMasterModel({
    required this.name,
    required this.category,
  });

  factory OpInvestigationMasterModel.fromJson(Map<String, dynamic> json) {
    return OpInvestigationMasterModel(
      name: json['name'] ?? '',
      category: json['category'] ?? 'Other',
    );
  }
}

/// ========== PROCEDURE MODEL ==========

class OpProcedureModel {
  final String name;
  final String? notes;

  OpProcedureModel({
    required this.name,
    this.notes,
  });

  factory OpProcedureModel.fromJson(Map<String, dynamic> json) {
    return OpProcedureModel(
      name: json['name'] ?? '',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
    };
  }
}

/// ========== FOLLOW-UP MODEL ==========

class OpFollowupModel {
  final DateTime date;
  final String? notes;
  final bool sendReminder;

  OpFollowupModel({
    required this.date,
    this.notes,
    this.sendReminder = true,
  });

  factory OpFollowupModel.fromJson(Map<String, dynamic> json) {
    return OpFollowupModel(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      notes: json['notes'],
      sendReminder: json['send_reminder'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'notes': notes,
      'send_reminder': sendReminder,
    };
  }
}

/// ========== MEDICAL HISTORY MODEL ==========

class OpMedicalHistoryModel {
  final List<String> pastMedicalHistory;
  final List<String> surgicalHistory;
  final List<String> familyHistory;
  final List<String> allergies;
  final String? smokingStatus;
  final String? alcoholStatus;
  final String? exerciseStatus;
  final String? notes;

  OpMedicalHistoryModel({
    this.pastMedicalHistory = const [],
    this.surgicalHistory = const [],
    this.familyHistory = const [],
    this.allergies = const [],
    this.smokingStatus,
    this.alcoholStatus,
    this.exerciseStatus,
    this.notes,
  });

  factory OpMedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    return OpMedicalHistoryModel(
      pastMedicalHistory: (json['past_medical_history'] as List?)?.map((e) => e.toString()).toList() ?? [],
      surgicalHistory: (json['surgical_history'] as List?)?.map((e) => e.toString()).toList() ?? [],
      familyHistory: (json['family_history'] as List?)?.map((e) => e.toString()).toList() ?? [],
      allergies: (json['allergies'] as List?)?.map((e) => e.toString()).toList() ?? [],
      smokingStatus: json['smoking_status'],
      alcoholStatus: json['alcohol_status'],
      exerciseStatus: json['exercise_status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'past_medical_history': pastMedicalHistory,
      'surgical_history': surgicalHistory,
      'family_history': familyHistory,
      'allergies': allergies,
      'smoking_status': smokingStatus,
      'alcohol_status': alcoholStatus,
      'exercise_status': exerciseStatus,
      'notes': notes,
    };
  }
}

/// ========== AI SUMMARY MODEL ==========

class OpAISummaryModel {
  final String patientName;
  final String ageDobGender;
  final String mrnUhid;
  final String dateOfVisit;
  final String consultingDoctor;
  final String departmentSpecialty;
  final Map<String, String> vitals;
  final List<String> chiefComplaints;
  final List<String> diagnosis;
  final List<String> clinicalFindings;
  final List<String> medicines;
  final List<String> investigations;
  final List<String> instructions;
  final String? followupDate;

  OpAISummaryModel({
    required this.patientName,
    required this.ageDobGender,
    required this.mrnUhid,
    required this.dateOfVisit,
    required this.consultingDoctor,
    required this.departmentSpecialty,
    this.vitals = const {},
    this.chiefComplaints = const [],
    this.diagnosis = const [],
    this.clinicalFindings = const [],
    this.medicines = const [],
    this.investigations = const [],
    this.instructions = const [],
    this.followupDate,
  });

  factory OpAISummaryModel.fromJson(Map<String, dynamic> json) {
    return OpAISummaryModel(
      patientName: json['patient_name'] ?? '',
      ageDobGender: json['age_dob_gender'] ?? '',
      mrnUhid: json['mrn_uhid'] ?? '',
      dateOfVisit: json['date_of_visit'] ?? '',
      consultingDoctor: json['consulting_doctor'] ?? '',
      departmentSpecialty: json['department_specialty'] ?? '',
      vitals: Map<String, String>.from(json['vitals'] ?? {}),
      chiefComplaints: (json['chief_complaints'] as List?)?.map((e) => e.toString()).toList() ?? [],
      diagnosis: (json['diagnosis'] as List?)?.map((e) => e.toString()).toList() ?? [],
      clinicalFindings: (json['clinical_findings'] as List?)?.map((e) => e.toString()).toList() ?? [],
      medicines: (json['medicines'] as List?)?.map((e) => e.toString()).toList() ?? [],
      investigations: (json['investigations'] as List?)?.map((e) => e.toString()).toList() ?? [],
      instructions: (json['instructions'] as List?)?.map((e) => e.toString()).toList() ?? [],
      followupDate: json['followup_date'],
    );
  }
}
