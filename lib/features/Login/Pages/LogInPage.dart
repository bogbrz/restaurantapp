import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/cubit/rootpage_cubit.dart';



class LogInPage extends StatefulWidget {
   LogInPage({
    super.key,
  });
final emailController = TextEditingController();
final passwordController = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                label: const Text("Email"),
              ),
              controller: widget.emailController,
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
              controller: widget.passwordController,
            ),
            Text(errorMessage),
            ElevatedButton(
              onPressed: () async {
                if (isCreatingAccount) {
                  //REGISTRATION
                  context
                      .read<RootpageCubit>()
                      .createAccount(widget.emailController.text, widget.passwordController.text);
                } else {
                  context.read<RootpageCubit>().signIn(widget.emailController.text, widget.passwordController.text)
                  //loging
                }
              },
              child: Text(isCreatingAccount ? "Create Account " : "Log in"),
            ),
            if (isCreatingAccount == false) ...[
              TextButton(
                  onPressed: () {
                    print(isCreatingAccount.toString());
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
