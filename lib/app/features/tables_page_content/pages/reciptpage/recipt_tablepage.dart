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

  var value1 = 0;
  var value2 = 0;
  var value3 = 0;
  var value4 = 0;

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
          child: BlocBuilder<PricemodelCubit, PricemodelState>(
            builder: (context, state) {
              final prices = state.pricies;
              return BlocBuilder<ReciptPageCubit, ReciptPageState>(
                builder: (context, state) {
                  final recipts = state.recipts;

                  for (final recipt in recipts) {
                    if (recipt.number == widget.tableModel &&
                        recipts.isNotEmpty) {
                      totalV1 = totalV1 += recipt.v1;
                      totalV2 += recipt.v2;
                      totalV3 += recipt.v3;
                      totalV4 += recipt.v4;
                    }
                    for (final price in prices) {
                      value1 = totalV1 * price.price1;
                      value2 = totalV2 * price.price2;
                      value3 = totalV3 * price.price3;
                      value4 = totalV4 * price.price4;
                    }
                  }

                  return ListView(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            child: const Text(
                              "Drinks",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            height: 45,
                            width: 45,
                            alignment: Alignment.center,
                            child: const Text(
                              "x",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            height: 50,
                            width: 65,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              border: Border.all(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            height: 50,
                            width: 65,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      BlocBuilder<TablecontentCubit, TablecontentState>(
                          builder: (context, state) {
                        if (state.tablePageModels.isEmpty) {
                          return const Center(
                            child: Text('no data avalibe'),
                          );
                        }
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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
                                child: Column(
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
                              ),
                            ],
                          ],
                        );
                      }),
                      Row(
                        children: [],
                      ),
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
                              child: Text(
                                totalV1.toString(),
                              ),
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
                                totalV2.toString(),
                              ),
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
                                totalV3.toString(),
                              ),
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
                                totalV4.toString(),
                              ),
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
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    price.price1.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    price.price2.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    price.price3.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    price.price4.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ]
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(value1.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(value2.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(value3.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(value4.toString()),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )
                    ]),
                    Center(
                      child: InkWell(
                        onTap: () {
                          for (final recipt in recipts) {
                            if (widget.tableModel == recipt.number)
                              context
                                  .read<ReciptPageCubit>()
                                  .removeOrder(recipt.id);
                          }

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: const Text('Finished'),
                        ),
                      ),
                    )
                  ]);
                },
              );
            },
          ),
        ));
  }
}
