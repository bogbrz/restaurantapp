import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({
    super.key,
  });

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
                for (final document in documents) ...[
                  Builder(builder: (context) {
                    return Tables(document: document);
                  })
                ]
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
      child: Container(
        color: Colors.orange,
        child: Column(
          children: [
            Center(
              child: Text(
                document['number'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
