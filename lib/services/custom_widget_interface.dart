import 'package:dynamic_widget/services/api_request_detail.dart';
import 'package:dynamic_widget/services/data_store.dart';

abstract class CustomWidgetInterface {
  // Reference to the DataStore
  DataStore get dataStore;

  // Custom Widget ID
  String get customWidgetId;

  // Values
  get value;
  set value(var newValue);

  // Appearance
  Map<String, dynamic> get appearance;
  set appearance(Map<String, dynamic> newAppearance);

  // Events
  void onEvent(String eventName, [dynamic eventData]);
  void createEvent(String eventName, [dynamic eventData]);

  // Validation with regex
  bool validateWithRegex(String pattern);

  // Get valid list from API
  Future<List<dynamic>> getValidListFromAPI(ApiRequestDetails requestDetails);

  // Set valid list
  void setValidList(List<dynamic> validList);

  // Validate with API
  Future<bool> validateWithAPI(ApiRequestDetails requestDetails);
}

