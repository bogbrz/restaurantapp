import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurantapp/app/features/pages/bar_page/cubit/barman_cubit.dart';
import 'package:restaurantapp/app/features/pages/bar_page/cubit/barmanaccount_cubit.dart';

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
  var newDate = '';
  var totalIncome = 0;

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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BarmanCubit(TableRepository())..start(),
          ),
          BlocProvider(
            create: (context) => BarmanAccountCubit(TableRepository())..start(),
          ),
        ],
        child: BlocBuilder<BarmanCubit, BarmanState>(
          builder: (context, state) {
            return BlocBuilder<BarmanAccountCubit, BarmanAccountState>(
              builder: (context, state) {
                final incomes = state.income;

                if (incomes.isEmpty) {
                  return CircularProgressIndicator();
                }
                for (final income in incomes) {
                  if (income.date == date) {
                    totalIncome += income.totalIncome;
                  }
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "Incomes: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange,
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Date : $date",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        "Day's earnings: $totalIncome ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<BarmanCubit>().signOut();
                          },
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Sign Out ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
