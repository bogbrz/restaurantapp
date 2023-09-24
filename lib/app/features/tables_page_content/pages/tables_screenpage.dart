import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';

class TableScreenPage extends StatelessWidget {
  const TableScreenPage({
    required this.tableModel,
    super.key,
  });
  final String tableModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TablePageCubit()..start(),
        child: BlocBuilder<TablePageCubit, TablePageState>(
          builder: (context, state) {
            final tableModels = state.tables;
            if (tableModels.isNotEmpty) {
              return ListView(
                children: [
                  Column(
                    children: [
                      Center(
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
                                        child: Text(tableModel),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  )
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
