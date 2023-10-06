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

  // @override
  // void initState() {
  //   super.initState();

  //   emailController.addListener(() {
  //     // Wywołuje setState za każdym razem, gdy zawartość kontrolera się zmieni
  //     setState(() {});
  //   });
  //   passwordController.addListener(() {
  //     setState(() {});
  //   });
  // }

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
              ElevatedButton(
                onPressed: // emailController.text.isEmpty ||
                    //         passwordController.text.isEmpty
                    //     ? null
                    //:
                    () async {
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
      ),
    );
  }

  // @override
  // void dispose() {

  //   passwordController.dispose();
  //   super.dispose();
  // }
}
