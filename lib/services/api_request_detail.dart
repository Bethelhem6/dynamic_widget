import 'dart:async'; // for Future

// Define API request details
class ApiRequestDetails {
  final String endpoint;
  final Map<String, String> parameters;
  final Map<String, String> headers;
  final dynamic body;

  ApiRequestDetails({
    required this.endpoint,
    this.parameters = const {},
    this.headers = const {},
    this.body,
  });
}
