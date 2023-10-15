import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/cubit/root_page_cubit.dart';
//a

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
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text("Restaurant App")),
      body: BlocListener<RootPageCubit, RootPageState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
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
              InkWell(
                onTap: () async {
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
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isCreatingAccount ? "Create Account " : "Log in",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              if (isCreatingAccount == false) ...[
                TextButton(
                    onPressed: () {
                      passwordController.clear();
                      emailController.clear();
                      setState(() {
                        isCreatingAccount = true;
                      });
                    },
                    child: const Text(
                      "Doesn't have an Account?",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                    onPressed: () {
                      passwordController.clear();
                      emailController.clear();
                      setState(() {
                        isCreatingAccount = false;
                      });
                    },
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ))
              ]
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {

  //   passwordController.dispose();
  //   super.dispose();
  // }
}
