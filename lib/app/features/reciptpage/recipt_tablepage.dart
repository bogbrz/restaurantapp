import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/reciptpage/cubit/recipt_page_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

class ReciptTablePage extends StatelessWidget {
  const ReciptTablePage({
    required this.tableModel,
    super.key,
  });
  final String tableModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("table number $tableModel"),
          backgroundColor: Colors.orange,
        ),
        body: BlocProvider(
          create: (context) => ReciptPageCubit(TableRepository())..start(),
          child: BlocBuilder<ReciptPageCubit, ReciptPageState>(
            builder: (context, state) {
              final recipts = state.recipts;
              return ListView(children: [
                for (final recipt in recipts) ...[
                  Column(
                    children: [
                      Container(
                        color: Colors.orange,
                        child: Text(recipt.v1.toString()),
                      ),
                      Container(
                        color: Colors.orange,
                        child: Text(recipt.v2.toString()),
                      ),
                      Container(
                        color: Colors.orange,
                        child: Text(recipt.v3.toString()),
                      ),
                      Container(
                        color: Colors.orange,
                        child: Text(recipt.v4.toString()),
                      ),
                    ],
                  ),
                ]
              ]);
            },
          ),
        ));
  }
}
