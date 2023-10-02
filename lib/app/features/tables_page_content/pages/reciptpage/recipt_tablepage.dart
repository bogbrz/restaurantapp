import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/reciptpage/cubit/pricemodel_cubit.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/reciptpage/cubit/recipt_page_cubit.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

class ReciptTablePage extends StatefulWidget {
  const ReciptTablePage({
    required this.tableModel,
    super.key,
  });
  final String tableModel;

  @override
  State<ReciptTablePage> createState() => _ReciptTablePageState();
}

class _ReciptTablePageState extends State<ReciptTablePage> {
  var totalV1 = 0;
  var totalV2 = 0;
  var totalV3 = 0;
  var totalV4 = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("table number ${widget.tableModel}"),
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
            BlocProvider(
              create: (context) => PricemodelCubit(TableRepository())..start(),
            ),
          ],
          child: BlocBuilder<ReciptPageCubit, ReciptPageState>(
            builder: (context, state) {
              final recipts = state.recipts;
              for (final recipt in recipts) {
                if (recipt.number == widget.tableModel && recipts.isNotEmpty) {
                  totalV1 = totalV1 += recipt.v1;
                  totalV2 += recipt.v2;
                  totalV3 += recipt.v3;
                  totalV4 += recipt.v4;
                }
              }

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
                          child: Text(totalV1.toString()),
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
                          child: Text(totalV2.toString()),
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
                          child: Text(totalV3.toString()),
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
                          child: Text(totalV4.toString()),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<PricemodelCubit, PricemodelState>(
                    builder: (context, state) {
                      final prices = state.pricies;
                      return Column(
                        children: [
                          for (final price in prices) ...[
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(price.price1.toString())),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(price.price2.toString())),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(price.price3.toString())),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(price.price4.toString())),
                            const SizedBox(
                              height: 16,
                            ),
                          ]
                        ],
                      );
                    },
                  )
                ]),
              ]);
            },
          ),
        ));
  }
}
