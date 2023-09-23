import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tables')
              .orderBy('number', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final documents = snapshot.data!.docs;

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
                      FirebaseFirestore.instance
                          .collection('tables')
                          .doc(document.id)
                          .delete();
                    },
                    child: Builder(builder: (context) {
                      return Center(child: Tables(document: document));
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
                          FirebaseFirestore.instance
                              .collection('tables')
                              .add({'number': tableNumberController.text});
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

class Tables extends StatelessWidget {
  const Tables({
    super.key,
    required this.document,
  });

  final QueryDocumentSnapshot<Object?> document;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            color: Colors.orange,
            child: Center(
              child: Text(
                document['number'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
