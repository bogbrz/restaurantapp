import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/reciptpage/cubit/recipt_page_cubit.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ReciptPageCubit(TableRepository())..start(),
            ),
            BlocProvider(
              create: (context) =>
                  TablecontentCubit(TableRepository())..start(),
            ),
          ],
          child: BlocBuilder<ReciptPageCubit, ReciptPageState>(
            builder: (context, state) {
              final recipts = state.recipts;

              return ListView(children: [
                Row(children: [
                  BlocBuilder<TablecontentCubit, TablecontentState>(
                      builder: (context, state) {
                    if (state.tablePageModels.isEmpty) {
                      return const Center(
                        child: Text('no data avalibe'),
                      );
                    }
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.errorMessage.isNotEmpty) {
                      return const Text("something went wrong");
                    }
                    final tablePageModels = state.tablePageModels;
                    return Column(
                      children: [
                        for (final tablePageModel in tablePageModels) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      color: Colors.orange,
                                    ),
                                    height: 50,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Text(tablePageModel.name),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ],
                    );
                  }),
                  for (final recipt in recipts) ...[
                    if (recipt.number == tableModel)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                color: Colors.orange,
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(recipt.v1.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                color: Colors.orange,
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(recipt.v2.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                color: Colors.orange,
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(recipt.v3.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                color: Colors.orange,
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(
                                recipt.v4.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ])
              ]);
            },
          ),
        ));
  }
}
