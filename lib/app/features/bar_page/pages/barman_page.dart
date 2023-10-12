import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/reciptpage/cubit/recipt_page_cubit.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

class BarmanPage extends StatefulWidget {
  const BarmanPage({super.key});

  @override
  State<BarmanPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BarmanPage> {
  var rv1 = 0;
  var rv2 = 0;
  var rv3 = 0;
  var rv4 = 0;
  var tnumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming orders'),
        backgroundColor: Colors.orange,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TablecontentCubit(TableRepository())..start(),
          ),
          BlocProvider(
            create: (context) => ReciptPageCubit(TableRepository())..start(),
          ),
        ],
        child: BlocBuilder<ReciptPageCubit, ReciptPageState>(
          builder: (context, state) {
            final recipts = state.recipts;

            return BlocBuilder<TablecontentCubit, TablecontentState>(
              builder: (context, state) {
                final tablePageModels = state.tablePageModels;

                return ListView(children: [
                  for (final recipt in recipts) ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.orange),
                        child: Column(children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 8, right: 8),
                                child: Text(
                                  "Table Number : ${recipt.number}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      ),
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
                                          ),
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
                                      ),
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
                                        ),
                                        child: Text(
                                          recipt.v1.toString(),
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
                                      ),
                                      child: Text(
                                        recipt.v2.toString(),
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
                                      ),
                                      child: Text(
                                        recipt.v4.toString(),
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
                                      ),
                                      child: Text(
                                        recipt.v4.toString(),
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
