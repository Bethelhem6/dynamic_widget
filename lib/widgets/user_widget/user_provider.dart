import 'package:flutter/material.dart';

enum Gender { male, female }

class UserProvider with ChangeNotifier {
  String name = '';
  String email = '';

  String phoneNumber = "";
  ValueNotifier<String> gender = ValueNotifier<String>("");
  ValueNotifier<bool> acceptTerms = ValueNotifier<bool>(false);
  ValueNotifier<String> selectedOption = ValueNotifier<String>('');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender.value == Gender.male ? 'Male' : 'Female',
      'acceptTerms': acceptTerms.value,
      'selectedOption': selectedOption.value,
    };
  }
}
