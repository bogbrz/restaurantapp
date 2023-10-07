import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/log/log_in_page.dart';
import 'package:restaurantapp/app/features/my_account_page/cubit/myaccount_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';
//a

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({
    super.key,
  });

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
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
                    'You are signed as ${emailController.text}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MyaccountCubit>().signOut();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Sign Out"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          height: 75,
                          width: 360,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Day's earnings:  ${totalIncome.toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200,
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
