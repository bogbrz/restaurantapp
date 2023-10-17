import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/pages/my_account_page/myaccountpage.dart';
import 'package:restaurantapp/app/features/pages/tables_page_content/cubit/table_page_cubit.dart';

import 'package:restaurantapp/app/navigators/tables_section_navigator.dart';
import 'package:restaurantapp/repositories/table_repository.dart';
//a

class TablesPage extends StatefulWidget {
  const TablesPage({
    super.key,
  });

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  final tableNumberController = TextEditingController();
  Set<String> addedNumbers = Set();
  @override
  void initState() {
    super.initState();
    tableNumberController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tableNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tables",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyAccountPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.person,
                size: 40,
              ))
        ],
      ),
      body: BlocProvider(
        create: (context) => TablePageCubit(TableRepository())..start(),
        child: BlocListener<TablePageCubit, TablePageState>(
          listener: (context, state) {
            if (state.isLoading) {
              const Center(child: CircularProgressIndicator());
            }
          },
          child: BlocBuilder<TablePageCubit, TablePageState>(
            builder: (context, state) {
              final tableModels = state.tables;

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                label: Text("Table number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                border: OutlineInputBorder()),
                            controller: tableNumberController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            final tableNumber = tableNumberController.text;
                            if (tableNumberController.text.isNotEmpty &&
                                !addedNumbers.contains(
                                  tableNumber,
                                )) {
                              context
                                  .read<TablePageCubit>()
                                  .add(tableNumberController.text);
                              addedNumbers.add(tableNumber);

                              tableNumberController.clear();
                            } else {
                              const Center(
                                child: Text(
                                    'Table with that number already exists'),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 4),
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(10)),
                            height: 60,
                            width: 60,
                            child: const Text(
                              '+',
                              style: TextStyle(fontSize: 40),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (final tableModel in tableModels) ...[
                    Dismissible(
                      key: ValueKey(tableModel.id),
                      background: const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.red),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.delete),
                            ),
                          )),
                      confirmDismiss: (direction) async {
                        return direction == DismissDirection.endToStart;
                      },
                      onDismissed: (_) {
                        final tableNumber = tableModel.number;
                        context.read<TablePageCubit>().remove(tableModel.id);
                        addedNumbers.remove(tableNumber);
                      },
                      child: Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 4)),
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Text(tableModel.number,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => TableHomePage(
                                                  tableModel: tableModel.number,
                                                )));
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
