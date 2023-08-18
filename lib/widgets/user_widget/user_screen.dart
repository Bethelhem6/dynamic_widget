import 'dart:convert';

import 'package:dynamic_widget/services/api_request_detail.dart';
import 'package:dynamic_widget/services/custom_widget_interface.dart';
import 'package:dynamic_widget/services/data_store.dart';
import 'package:dynamic_widget/widgets/profile_widget/profile_screen.dart';
import 'package:dynamic_widget/widgets/user_widget/user_provider.dart';
import 'package:dynamic_widget/widgets/user_widget/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget implements CustomWidgetInterface {
  static const routeName = "/register";

  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();

  @override
  Map<String, dynamic> appearance = {
    "bodyTextColor": Colors.black,
    "bodyTextFontSize": 15.0,
    "titleTextFontSize": 20.0,
    "buttonColor": Colors.deepPurple,
  };

  @override
  var value;

  @override
  void createEvent(String eventName, [eventData]) {}

  @override
  String get customWidgetId => "UserScreenId";

  @override
  DataStore get dataStore => throw UnimplementedError();

  @override
  Future<List> getValidListFromAPI(ApiRequestDetails requestDetails) {
    throw UnimplementedError();
  }

  @override
  void onEvent(String eventName, [eventData]) {
    eventName = "_onSubmit";
    eventData = [eventName];
  }

  @override
  void setValidList(List validList) {}

  @override
  Future<bool> validateWithAPI(ApiRequestDetails requestDetails) {
    throw UnimplementedError();
  }

  @override
  bool validateWithRegex(String pattern) {
    throw UnimplementedError();
  }
}

class _UserScreenState extends State<UserScreen> {
  final userNameControl = TextEditingController();
  final emailControl = TextEditingController();

  final phoneControl = TextEditingController();
  final passwordControl = TextEditingController();

  var invisible = false;

  void changeSate() {
    if (invisible) {
      setState(() {
        invisible = false;
      });
    } else {
      setState(() {
        invisible = true;
      });
    }
  }

  bool _onProcess = false;
  final _registerFormKey = GlobalKey<FormState>();

  String _selectedGender = "Male";

  final List<String> _cities = [
    'Addis Ababa',
    'Bahirdar',
    'Adama',
    'Hawassa',
    'Gondar'
  ];

  bool isOffline = false;

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  void initState() {
    _onProcess = false;

    super.initState();
  }

  @override
  void dispose() {
    phoneControl.dispose();

    emailControl.dispose();

    passwordControl.dispose();

    userNameControl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(
          backgroundColor: widget.appearance["buttonColor"],
          title: Text(
            "Registration Form",
            style: TextStyle(fontSize: widget.appearance["titleTextFontSize"]),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Form(
          key: _registerFormKey,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[50],
                          //border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(20, 100, 20, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Column(
                        children: <Widget>[
                          _nameTextField(),
                          _phoneNumberTextField(),
                          _emailField(),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Male',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .gender
                                      .value = value!;
                                },
                              ),
                              const Text('Male',
                                  style: TextStyle(color: Colors.grey)),
                              Radio<String>(
                                value: 'Female',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .gender
                                      .value = value!;
                                },
                              ),
                              const Text(
                                'Female',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          _cityDropdown(),
                          _passwordFileld(),
                          CheckboxListTile(
                            title: const Text('Accept Terms'),
                            value: Provider.of<UserProvider>(context)
                                .acceptTerms
                                .value,
                            onChanged: (value) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .acceptTerms
                                  .value = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 40,
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: GestureDetector(
                                onTap: _onProcess ? null : _onSubmit,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    Container(
                                      color: widget.appearance["buttonColor"],
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 30),
                                      child: Text("REGISTER",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: widget.appearance[
                                                  "titleTextFontSize"])),
                                    ),
                                    const Spacer(),
                                    Align(
                                      widthFactor: 2,
                                      alignment: Alignment.centerRight,
                                      child: _onProcess
                                          ? const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _onSubmit() {
    final form = _registerFormKey.currentState;
    if (form!.validate()) {
      setState(() {
        _onProcess = true;
      });
      form.save();
      var jsonData = Provider.of<UserProvider>(context, listen: false).toJson();
      // print(jsonData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            user: jsonData,
          ),
        ),
        
      );
    }
  }

  _cityDropdown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<String>(
        onChanged: (value) {
          Provider.of<UserProvider>(context, listen: false)
              .selectedOption
              .value = value!;
        },
        items: _cities.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Text(city),
          );
        }).toList(),
        decoration: const InputDecoration(
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            Icons.location_on_rounded,
          ),
          labelText: 'City',
          labelStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _passwordFileld() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(color: widget.appearance["bodyTextColor"]),
        controller: passwordControl,
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: const Text("Password"),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: _onProcess ? null : changeSate,
            child: Icon(
              invisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) => Sanitizer().isPasswordValid(value!),
      ),
    );
  }

  _emailField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(color: widget.appearance["bodyTextColor"]),
        controller: emailControl,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: const Text("Email"),
          prefixIcon: const Icon(
            Icons.email,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) => Sanitizer().isEmailValid(value!),
        onChanged: (value) {
          Provider.of<UserProvider>(context, listen: false).email = value;
        },
      ),
    );
  }

  _phoneNumberTextField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(color: widget.appearance["bodyTextColor"]),
        controller: phoneControl,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: const Text("Phone Number"),
          prefixIcon: const Icon(
            Icons.phone,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) => Sanitizer().isPhoneValid(value!),
        onSaved: (value) {
          Provider.of<UserProvider>(context, listen: false).phoneNumber =
              value!;
        },
      ),
    );
  }

  _nameTextField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(color: widget.appearance["bodyTextColor"]),
        controller: userNameControl,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: const Text("Full Name"),
          prefixIcon: const Icon(
            Icons.person,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) => Sanitizer().isFullNameValid(value!),
        onSaved: (value) {
          Provider.of<UserProvider>(context, listen: false).name = value!;
        },
      ),
    );
  }
}
