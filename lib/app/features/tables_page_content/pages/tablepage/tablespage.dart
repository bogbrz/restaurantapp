import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';
import 'package:restaurantapp/app/tablehomepage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tables"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => TablePageCubit(TableRepository())..start(),
        child: BlocListener<TablePageCubit, TablePageState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                  backgroundColor: Colors.red,
                ),
              );
            }
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
                                  label: Text(
                                    "Table number",
                                  ),
                                  border: OutlineInputBorder()),
                              controller: tableNumberController),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<TablePageCubit>()
                                .add(tableNumberController.text);

                            tableNumberController.clear();
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
                        context.read<TablePageCubit>().remove(tableModel.id);
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
                                      child: Text(
                                        tableModel.number,
                                      ),
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
