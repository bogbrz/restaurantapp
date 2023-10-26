import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurantapp/app/features/pages/log_in_page/log_in_page.dart';
import 'package:restaurantapp/app/features/pages/my_account_page/cubit/myaccount_cubit.dart';
import 'package:restaurantapp/data_source_repositories/remote_data_source/data_source.dart';
import 'package:restaurantapp/data_source_repositories/repositories/table_repository.dart';
//a

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({
    super.key,
  });

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
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
        create: (context) =>
            MyaccountCubit(TableRepository(DataSource()))..start(),
        child: BlocBuilder<MyaccountCubit, MyaccountState>(
          builder: (context, state) {
            final totals = state.totals;
            for (final total in totals) {
              totalIncome += total.total;
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 65,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'You are signed as: ${emailController.text}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange,
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  "Date : $date,",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(
                                  "Day's earnings:  $totalIncome",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            for (final total in context
                                .read<MyaccountCubit>()
                                .state
                                .totals) {
                              if (total.date == date) {
                                context
                                    .read<MyaccountCubit>()
                                    .removeEnd(total.id);
                              }
                            }
                            context
                                .read<MyaccountCubit>()
                                .addEnd(totalIncome, date);

                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => const MyAccountPage()),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Close day",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<MyaccountCubit>().signOut();
                            Navigator.of(context).pop();
                          },
                          child: Container(
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
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
