class NoResponseException implements Exception {
  final String message;

  NoResponseException({required this.message});

  @override
  String toString() => message;
}
