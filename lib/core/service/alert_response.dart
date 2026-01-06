class AlertResponse {
  final String? title;
  final int? id;
  final String? subtitle;
  final bool status;

  AlertResponse({
    this.title,
    this.id,
    this.subtitle,
    required this.status,
  });
}
