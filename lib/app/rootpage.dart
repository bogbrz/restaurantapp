import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/navigators/barman_section_navigator.dart';
import 'package:restaurantapp/app/cubit/root_page_cubit.dart';
import 'package:restaurantapp/app/features/pages/log_in_page/log_in_page.dart';
import 'package:restaurantapp/app/features/pages/tables_page_content/pages/tablepage/tablespage.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

//a

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootPageCubit(TableRepository())..start(),
      child: BlocBuilder<RootPageCubit, RootPageState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return const LogInPage();
          }
          if (user.email == "barman@wp.pl") {
            return const BarmanHomePage();
          }

          return const TablesPage();
        },
      ),
    );
  }
}
