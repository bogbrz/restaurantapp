import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    required this.onSave,
    super.key,
  });
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("My Account")),
    );
  }
}
