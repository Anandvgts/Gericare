class ErrorResponseException implements Exception {
  final String? error;

  ErrorResponseException({this.error});

  @override
  String toString() => error ?? 'Unknown error';
}
