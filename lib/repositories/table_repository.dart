import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurantapp/models/pricemodel.dart';
import 'package:restaurantapp/models/reciptmodel.dart';
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

  Stream<List<PriceModel>> getPriceStream() {
    return FirebaseFirestore.instance
        .collection('prices')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return PriceModel(
            price1: doc['price1'],
            price2: doc['price2'],
            price3: doc['price3'],
            price4: doc['price4']);
      }).toList();
    });
  }

  Future<void> remove({required String id}) {
    return FirebaseFirestore.instance.collection('tables').doc(id).delete();
  }

  Future<ReciptModel> get({required String number}) async {
    final doc =
        await FirebaseFirestore.instance.collection('orders').doc(number).get();
    return ReciptModel(
        v1: doc['Rum'],
        v2: doc['Tequilla'],
        v3: doc['Aperol'],
        v4: doc['Whiskey'],
        number: doc['tablenumber']);
  }

  Future<void> add2(
      {required String tableNumber,
      required int v1,
      required int v2,
      required int v3,
      required int v4}) {
    return FirebaseFirestore.instance.collection('orders').add(
      {
        'Rum': v1,
        'Tequilla': v2,
        'Aperol': v3,
        'Whiskey': v4,
        'tablenumber': tableNumber,
      },
    );
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

  Stream<List<ReciptModel>> getReciptModelStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ReciptModel(
              v1: doc['Rum'],
              v2: doc['Tequilla'],
              v3: doc['Aperol'],
              v4: doc['Whiskey'],
              number: doc['tablenumber']);
        },
      ).toList();
    });
  }

  Future<void> removeDrink({required String id}) {
    return FirebaseFirestore.instance.collection('drinks').doc(id).delete();
  }
}
