import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';

class TableScreenPage extends StatelessWidget {
  const TableScreenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TablePageCubit()..start(),
        child: BlocBuilder<TablePageCubit, TablePageState>(
          builder: (context, state) {
            final documents = state.documents;
            return ListView(
              children: [
                for (final document in documents) ...[
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
                                        child: Text(
                                          document['number'],
                                        ),
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
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
