import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';

class TableScreenPage extends StatefulWidget {
  const TableScreenPage({
    required this.tableModel,
    super.key,
  });
  final String tableModel;

  @override
  State<TableScreenPage> createState() => _TableScreenPageState();
}

List<String> items = ['Piwo', 'Wódeczka', "Aperolek", "Sexik"];

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
        create: (context) => TablePageCubit()..start(),
        child: BlocBuilder<TablePageCubit, TablePageState>(
          builder: (context, state) {
            final tableModels = state.tables;
            if (tableModels.isNotEmpty) {
              return ListView(
                children: [
                  for (final item in items) ...[
                    Dismissible(
                      key: ValueKey(item),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.orange),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 100,
                                          color: Colors.orange,
                                          alignment: Alignment.center,
                                          child: Text(item),
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
            } else {
              return const Center(
                child: Text('something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
