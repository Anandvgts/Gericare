/// Enum to represent the type of care/appointment
enum CareType {
  /// Assisted Living
  al,

  /// Outpatient
  op,

  /// Home Care
  homeCare,
}

extension CareTypeExtension on CareType {
  String get label {
    switch (this) {
      case CareType.al:
        return 'Assisted Living';
      case CareType.op:
        return 'Outpatient';
      case CareType.homeCare:
        return 'Home Care';
    }
  }

  String get shortLabel {
    switch (this) {
      case CareType.al:
        return 'AL';
      case CareType.op:
        return 'OP';
      case CareType.homeCare:
        return 'HC';
    }
  }
}

/// Payment status for appointments
enum PaymentStatus {
  paid,
  unpaid,
  pending,
}

extension PaymentStatusExtension on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.unpaid:
        return 'Unpaid';
      case PaymentStatus.pending:
        return 'Pending';
    }
  }
}

/// Appointment status
enum AppointmentStatus {
  upcoming,
  inProgress,
  completed,
  cancelled,
}

extension AppointmentStatusExtension on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.upcoming:
        return 'Upcoming';
      case AppointmentStatus.inProgress:
        return 'In Progress';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}
