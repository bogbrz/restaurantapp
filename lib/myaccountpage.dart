import 'package:flutter/material.dart';
import 'package:restaurantapp/LogInPage.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    required this.onSave,
    super.key,
  });
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You are sign as ${emailController.text}',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Sign Out"),
          ),
        ],
      )),
    );
  }
}
