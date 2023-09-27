import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

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
                for (final tablePageModel in tablePageModels) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(children: [
                          Row(
                            children: [
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
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.red,
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "+",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.red,
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "-",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.green,
                                  height: 50,
                                  width: 60,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
