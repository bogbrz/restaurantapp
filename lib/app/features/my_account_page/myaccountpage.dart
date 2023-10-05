import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/cubit/root_page_cubit.dart';
import 'package:restaurantapp/app/features/log/log_in_page.dart';
//a

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    required this.onSave,
    super.key,
  });
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<RootPageCubit>().signOut();
            },
            child: const Text("Sign Out"),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'You are signed as ${emailController.text}',
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
