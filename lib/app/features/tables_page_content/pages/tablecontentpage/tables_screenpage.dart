import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/cubit/tablecontent_cubit.dart';

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
        create: (context) => TablecontentCubit()..start(),
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
                for (final tablePageModel in tablePageModels) ...[
                  Dismissible(
                    key: ValueKey(tablePageModel.id),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                              ],
                            )
                          ]),
                        ],
                      ),
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
