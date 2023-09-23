import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/cubit/rootpage_cubit.dart';
import 'package:restaurantapp/features/Login/Pages/LogInPage.dart';
import 'package:restaurantapp/firebase_options.dart';
import 'package:restaurantapp/features/Home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RootPage());
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootpageCubit(),
      child: BlocBuilder<RootpageCubit, RootpageState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                state.errorMessage.toString(),
              ),
            );
          }
          if (state.isLoading) {
            return const CircularProgressIndicator();
          }
          final user = state.user;

          if (user == null) {
            return const LogInPage();
          }
          return const HomePage();

          return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data;
              });
        },
      ),
    );
  }
}
