import 'package:flutter/foundation.dart';

class DataStore with ChangeNotifier {
  // This map will store the common JSON data.
  Map<String, dynamic> _commonJson = {};

  // A method to access the commonJson.
  Map<String, dynamic> get commonJson => _commonJson;

  // A method to update any part of the commonJson and notify all listeners.
  void updateCommonJson(Map<String, dynamic> updates) {
    _commonJson = {..._commonJson, ...updates};
    notifyListeners();
  }

  // Handle the events. This can be expanded to have more specific logic.
  void handleEvent(String eventName, [dynamic eventData]) {
    // Example: Event handling logic. Depending on eventName, you can perform various actions.
    if (eventName == "someEventName") {
      // Handle specific event
      // You can also update the _commonJson here if required.
    }
    // Ensure to notify listeners if any data changes.
    notifyListeners();
  }
}
// {
//   "widget1Id": {
//     "value": "Some Value",
//     "appearance": {
//       "color": "#FF5733",
//       "fontSize": 16
//       // ... other appearance properties
//     },
//     "events": [
//       // Example events
//       {"eventName": "clicked", "timestamp": "2023-08-13T12:00:00Z"},
//       {"eventName": "valueChanged", "timestamp": "2023-08-13T12:05:00Z"}
//     ]
//   },
//   "widget2Id": {
//     // ... similar structure as widget1Id
//   }
//   // ... other widget data
// }