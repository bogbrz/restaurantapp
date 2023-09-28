import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';
import 'package:restaurantapp/app/features/tables_page_content/pages/tablecontentpage/tables_screenpage.dart';
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
                    child: TextField(
                        decoration: const InputDecoration(
                            label: Text(
                              "Table number",
                            ),
                            border: OutlineInputBorder()),
                        controller: tableNumberController),
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
                                    height: 50,
                                    width: 50,
                                    color: Colors.orange,
                                    child: Center(
                                      child: Text(
                                        tableModel.number,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => TableScreenPage(
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
                  Column(
                    children: [
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<TablePageCubit>()
                                .add(tableNumberController.text);
                          },
                          child: const Text('Add'),
                        ),
                      ),
                    ],
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
