import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
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
  var counter = 0;
  var v1 = 0;
  var v2 = 0;
  var v3 = 0;
  var v4 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          "table number ${widget.tableModel}",
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

            print('counter is$counter');

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            border: Border.all(color: Colors.black, width: 5)),
                        height: 40,
                        width: 116,
                        alignment: Alignment.center,
                        child: const Text(
                          "Operands",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            border: Border.all(color: Colors.black, width: 5)),
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
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        for (final tablePageModel in tablePageModels) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Container(
                                decoration:
                                    const BoxDecoration(color: Colors.orange),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 100,
                                      color: Colors.orange,
                                      alignment: Alignment.center,
                                      child: Text(tablePageModel.name),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ],
                    ),
                    Column(
                      children: [
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '+',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '+',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '+',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '+',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '-',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '-',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '-',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
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
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.red,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '-',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 60,
                                      color: Colors.green,
                                      alignment: Alignment.center,
                                      child: Text(v1.toString())),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 60,
                                      color: Colors.green,
                                      alignment: Alignment.center,
                                      child: Text(v2.toString())),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 60,
                                      color: Colors.green,
                                      alignment: Alignment.center,
                                      child: Text(v3.toString())),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 60,
                                      color: Colors.green,
                                      alignment: Alignment.center,
                                      child: Text(v4.toString())),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    FirebaseFirestore.instance.collection('orders').add({
                      'Rum': v1,
                      'Tequilla': v2,
                      'Aperol': v3,
                      'Whiskey': v4,
                      'tablenumber': widget.tableModel,
                    });
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
