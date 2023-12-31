import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/pages/bar_page/cubit/barman_cubit.dart';
import 'package:restaurantapp/app/features/pages/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
import 'package:restaurantapp/data_source_repositories/remote_data_source/data_source.dart';

import 'package:restaurantapp/data_source_repositories/repositories/table_repository.dart';

class BarmanPage extends StatefulWidget {
  const BarmanPage({super.key});

  @override
  State<BarmanPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BarmanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Incoming orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                TablecontentCubit(TableRepository(DataSource()))..start(),
          ),
          BlocProvider(
            create: (context) =>
                BarmanCubit(TableRepository(DataSource()))..start(),
          ),
        ],
        child: BlocBuilder<BarmanCubit, BarmanState>(
          builder: (context, state) {
            final orders = state.orders;

            return BlocBuilder<TablecontentCubit, TablecontentState>(
              builder: (context, state) {
                final tablePageModels = state.tablePageModels;

                return ListView(children: [
                  for (final order in orders) ...[
                    Dismissible(
                      key: ValueKey(order.id),
                      background: const Padding(
                        padding: EdgeInsets.only(right: 30, top: 20),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return direction == DismissDirection.endToStart;
                      },
                      onDismissed: (_) {
                        context.read<BarmanCubit>().removeBarOder(order.id);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(width: 2, color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 8, right: 8),
                                  child: Text(
                                    "Table Number : ${order.number}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 8, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Text(
                                          "Drinks",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      for (final tablePageModel
                                          in tablePageModels) ...[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.black,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              tablePageModel.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Text(
                                          "X",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            order.v1.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          order.v2.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          order.v3.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          order.v4.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ]
                ]);
              },
            );
          },
        ),
      ),
    );
  }
}
