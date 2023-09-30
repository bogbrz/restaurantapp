import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/app/features/reciptpage/recipt_tablepage.dart';
import 'package:restaurantapp/app/features/tables_page_content/cubit/table_page_cubit.dart';
import 'package:restaurantapp/repositories/table_repository.dart';
//a

class ReciptPage extends StatelessWidget {
  const ReciptPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipts'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => TablePageCubit(TableRepository())..start(),
        child: BlocBuilder<TablePageCubit, TablePageState>(
          builder: (context, state) {
            final tableModels = state.tables;

            return ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Choose the table",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
                for (final tableModel in tableModels) ...[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ReciptTablePage(
                                        tableModel: tableModel.number,
                                      ))),
                          child: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            color: Colors.orange,
                            child: Text(tableModel.number),
                          ),
                        ),
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
