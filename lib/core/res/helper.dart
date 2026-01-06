class Helper {
  static String formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final suffix = dt.hour >= 12 ? "PM" : "AM";
    return "${hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} $suffix";
  }

  static String fullDateLabel(DateTime date) {
    return "Sun, June 6"; // replace with intl if needed
  }

  static String formatQuantity(double value, {required bool isTablet}) {
    if (!isTablet) {
      // Syrup → decimal
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    // Tablet → fraction
    final whole = value.floor();
    final frac = value - whole;

    if (frac == 0) return whole.toString();
    if (frac == 0.5) {
      return whole == 0 ? '½' : '$whole½';
    }

    return value.toString(); // fallback
  }

  static String getFormattedDate() => "Wednesday, 7 Nov";
}
