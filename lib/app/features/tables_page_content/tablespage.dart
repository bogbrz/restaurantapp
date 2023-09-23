import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';

class TablesPage extends StatelessWidget {
  TablesPage({
    super.key,
  });
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
        create: (context) => TablePageCubit()..start(),
        child: BlocListener<TablePageCubit, TablePageState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
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
              final documents = state.documents;

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
                  for (final document in documents) ...[
                    Dismissible(
                      key: ValueKey(document.id),
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
                        context.read<TablePageCubit>().remove(document.id);
                      },
                      child: Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.orange,
                                  child: Center(
                                    child: Text(
                                      document['number'],
                                    ),
                                  ),
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
