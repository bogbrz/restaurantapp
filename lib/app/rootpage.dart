import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/cubit/root_page_cubit.dart';
import 'package:restaurantapp/app/features/log/log_in_page.dart';
import 'package:restaurantapp/app/homepage.dart';
//a

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootPageCubit()..start(),
      child: BlocBuilder<RootPageCubit, RootPageState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return const LogInPage();
          }
          return const HomePage();
        },
      ),
    );
  }
}
