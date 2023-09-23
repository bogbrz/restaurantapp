import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/cubit/root_page_cubit.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

class LogInPage extends StatefulWidget {
  const LogInPage({
    super.key,
  });

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var errorMessage = "";
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text("Restaurant App")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                label: const Text("Email"),
              ),
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                label: const Text("Password"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (isCreatingAccount) {
                  context.read<RootPageCubit>().createAccount(
                      emailController.text, passwordController.text);
                  //REGISTRATION
                } else {
                  context
                      .read<RootPageCubit>()
                      .sigIn(emailController.text, passwordController.text);
                  //loging
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text(isCreatingAccount ? "Create Account " : "Log in"),
            ),
            if (isCreatingAccount == false) ...[
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: const Text("Doesn't have an Account?")),
            ],
            if (isCreatingAccount == true) ...[
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: const Text("Already have an account?"))
            ]
          ],
        ),
      ),
    );
  }
}
