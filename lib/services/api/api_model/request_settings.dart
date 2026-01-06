class RequestSettings {
  final String method;
  final String endPoint;
  final Object? params;
  final bool authenticated;

  RequestSettings(
    this.method,
    this.endPoint, {
    this.params,
    this.authenticated = true,
  });
}
