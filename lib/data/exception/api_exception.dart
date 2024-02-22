class ApiException implements Exception {
  final int? statusCode;
  final String? responseData;

  ApiException(this.statusCode, this.responseData);
}
