import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/cubit/root_page_cubit.dart';
import 'package:restaurantapp/app/features/log/log_in_page.dart';
import 'package:restaurantapp/app/features/my_account_page/cubit/myaccount_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';
//a

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({
    required this.onSave,
    super.key,
  });
  final Function onSave;

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var totalIncome = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => MyaccountCubit(TableRepository())..start(),
        child: BlocBuilder<MyaccountCubit, MyaccountState>(
          builder: (context, state) {
            final totals = state.totals;
            for (final total in totals) {
              totalIncome += total.total;
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            border: Border.all(color: Colors.black, width: 2)),
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Day's earnings:  ${totalIncome.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RootPageCubit>().signOut();
                    },
                    child: const Text("Sign Out"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You are signed as ${emailController.text}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
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
