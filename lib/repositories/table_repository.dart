import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurantapp/models/tablemodel.dart';

class TableRepository {
  Stream<List<TableModel>> getTablesStream() {
    return FirebaseFirestore.instance
        .collection('tables')
        .orderBy('number', descending: false)
        .snapshots()
        .map((querySnaphot) {
      return querySnaphot.docs.map((doc) {
        return TableModel(id: doc.id, number: doc['number']);
      }).toList();
    });
  }

  Future<void> remove({required String id}) {
    return FirebaseFirestore.instance.collection('tables').doc(id).delete();
  }

  Future<void> add({required String tableNumber}) {
    return FirebaseFirestore.instance.collection('tables').add(
      {
        'number': tableNumber,
      },
    );
  }
}
