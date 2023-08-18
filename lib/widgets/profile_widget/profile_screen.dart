import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});
  final user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "User Name: ${user['name']}",
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            ),
            Text(
              "Email: ${user['email']}",
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            ),
            Text(
              "Phone Number: ${user['phoneNumber']}",
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Go Back",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
