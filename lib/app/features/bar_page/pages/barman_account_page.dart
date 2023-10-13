import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurantapp/app/features/bar_page/cubit/barman_cubit.dart';

import 'package:restaurantapp/repositories/table_repository.dart';
//a

class BarmanAccountPage extends StatefulWidget {
  const BarmanAccountPage({
    super.key,
  });

  @override
  State<BarmanAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<BarmanAccountPage> {
  var date = DateFormat.yMMMd().format(DateTime.now());
  int totalIncome = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => BarmanCubit(TableRepository()),
        child: BlocBuilder<BarmanCubit, BarmanState>(
          builder: (context, state) {
            return Column(
              children: [
                const Center(
                  child: Text('barman accoubt'),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<BarmanCubit>().signOut();
                    },
                    child: const Text("Sign out"))
              ],
            );
          },
        ),
      ),
    );
  }
}
