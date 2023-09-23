import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/features/Table/cubit/tablepage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantapp/features/Table/tablewidget.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({
    super.key,
  });

  @override
  State<TablesPage> createState() => _TablesPageState();
}

int tableNumber = 0;
final controller = TextEditingController();

class _TablesPageState extends State<TablesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tables"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocProvider(
        create: (context) => TablepageCubit()..start(),
        child: BlocBuilder<TablepageCubit, TablepageState>(
          builder: (context, state) {
            if (state.errorMessage.isEmpty) {
              return const Text("Something went wrong");
            }
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }
            final documents = state.documents;

            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("tables")
                    .orderBy('number', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            decoration: InputDecoration(
                                label: const Text("table number"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            controller: controller),
                      ),
                      for (final document in documents) ...[
                        Dismissible(
                          key: ValueKey(document.id),
                          onDismissed: (_) {
                            FirebaseFirestore.instance
                                .collection('tables')
                                .doc(document.id)
                                .delete();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TableWidget(
                                tableNumber: document['number'],
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('tables').add(
            {
              'number': controller.text,
            },
          );
          controller.clear();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
