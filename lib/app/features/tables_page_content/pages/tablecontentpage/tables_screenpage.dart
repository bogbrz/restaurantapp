import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';
//a

class TableScreenPage extends StatefulWidget {
  const TableScreenPage({
    required this.tableModel,
    super.key,
  });
  final String tableModel;

  @override
  State<TableScreenPage> createState() => _TableScreenPageState();
}

class _TableScreenPageState extends State<TableScreenPage> {
  var v1 = 0;
  var v2 = 0;
  var v3 = 0;
  var v4 = 0;
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Table number ${widget.tableModel}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => TablecontentCubit(TableRepository())..start(),
        child: BlocBuilder<TablecontentCubit, TablecontentState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage.isNotEmpty) {
              return const Text("something went wrong");
            }

            final tablePageModels = state.tablePageModels;

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Drinks(tablePageModels: tablePageModels),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                border:
                                    Border.all(color: Colors.black, width: 5)),
                            height: 40,
                            width: 120,
                            alignment: Alignment.center,
                            child: const Text(
                              "Operands",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v1++;
                                        });
                                      },
                                      child: const OperandAddButton(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v2++;
                                        });
                                      },
                                      child: const OperandAddButton(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v3++;
                                        });
                                      },
                                      child: const OperandAddButton(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v4++;
                                        });
                                      },
                                      child: const OperandAddButton(),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v1 == 0 ? v1 = 0 : v1 = v1 - 1;
                                        });
                                      },
                                      child: const OperandMinusButton(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v2 == 0 ? v2 = 0 : v2 = v2 - 1;
                                        });
                                      },
                                      child: const OperandMinusButton(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v3 == 0 ? v3 = 0 : v3 = v3 - 1;
                                        });
                                      },
                                      child: const OperandMinusButton(),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          v4 == 0 ? v4 = 0 : v4 = v4 - 1;
                                        });
                                      },
                                      child: const OperandMinusButton(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                border:
                                    Border.all(color: Colors.black, width: 5)),
                            height: 40,
                            width: 60,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                AmountOfDrinks(v1: v1, v2: v2, v3: v3, v4: v4),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    context
                        .read<TablecontentCubit>()
                        .add(widget.tableModel, v1, v2, v3, v4);
                    context
                        .read<TablecontentCubit>()
                        .addBar(widget.tableModel, v1, v2, v3, v4);

                    setState(() {
                      v1 = 0;
                      v2 = 0;
                      v3 = 0;
                      v4 = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 4),
                      color: Colors.orange,
                    ),
                    width: 150,
                    alignment: Alignment.center,
                    child: const Text(
                      "Order",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AmountOfDrinks extends StatelessWidget {
  const AmountOfDrinks({
    super.key,
    required this.v1,
    required this.v2,
    required this.v3,
    required this.v4,
  });

  final int v1;
  final int v2;
  final int v3;
  final int v4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.black, width: 2)),
            height: 54,
            width: 54,
            alignment: Alignment.center,
            child: Text(v1.toString())),
        const SizedBox(
          height: 16,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.black, width: 2)),
            height: 54,
            width: 54,
            alignment: Alignment.center,
            child: Text(v2.toString())),
        const SizedBox(
          height: 16,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.black, width: 2)),
            height: 54,
            width: 54,
            alignment: Alignment.center,
            child: Text(v3.toString())),
        const SizedBox(
          height: 16,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.black, width: 2)),
            height: 54,
            width: 54,
            alignment: Alignment.center,
            child: Text(v4.toString())),
      ],
    );
  }
}

class Drinks extends StatelessWidget {
  const Drinks({
    super.key,
    required this.tablePageModels,
  });

  final List<TablePageModel> tablePageModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(color: Colors.black, width: 5)),
          height: 40,
          width: 100,
          alignment: Alignment.center,
          child: const Text(
            "Drinks",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        for (final tablePageModel in tablePageModels) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.orange,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      color: Colors.orange,
                      alignment: Alignment.center,
                      child: Text(
                        tablePageModel.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ],
    );
  }
}

class OperandMinusButton extends StatelessWidget {
  const OperandMinusButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black, width: 2),
      ),
      height: 54,
      width: 54,
      alignment: Alignment.center,
      child: const Text(
        '-',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 35),
      ),
    );
  }
}

class OperandAddButton extends StatelessWidget {
  const OperandAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black, width: 2),
      ),
      height: 54,
      width: 54,
      alignment: Alignment.center,
      child: const Text(
        '+',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 35),
      ),
    );
  }
}
