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

class _TableScreenPageState extends State<TableScreenPage> {
  String selectedItem = 'Wódeczka';
  final List<String> items = ['Wódeczka', "Aperolek", "Sexik"];

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            color: Colors.orange,
                            child: DropdownButton<String>(
                              value: selectedItem,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedItem = newValue.toString();
                                });
                              },
                              items: items.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  alignment: Alignment.center,
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
