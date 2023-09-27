import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurantapp/models/tablemodel.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';

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

  Stream<List<TablePageModel>> getTableModelStream() {
    return FirebaseFirestore.instance
        .collection('drinks')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TablePageModel(name: doc['name'], id: doc.id);
      }).toList();
    });
  }

  Future<void> removeDrink({required String id}) {
    return FirebaseFirestore.instance.collection('drinks').doc(id).delete();
  }
}
