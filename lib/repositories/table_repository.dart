import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurantapp/models/incomemodel.dart';
import 'package:restaurantapp/models/ordermodel.dart';
import 'package:restaurantapp/models/pricemodel.dart';
import 'package:restaurantapp/models/reciptmodel.dart';
import 'package:restaurantapp/models/tablemodel.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';
import 'package:restaurantapp/models/totalmodel.dart';

class TableRepository {
  Stream<List<TableModel>> getTablesStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
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

  Stream<List<IncomeModel>> getIncomeStream() {
    return FirebaseFirestore.instance
        .collection('Income')
        .orderBy('date', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return IncomeModel(
            totalIncome: doc['totalIncome'], id: doc.id, date: doc['date']);
      }).toList();
    });
  }

  Stream<List<TotalModel>> getTotalStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('totals')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TotalModel(total: doc['total'], id: doc.id, date: doc['date']);
      }).toList();
    });
  }

  Future<void> remove({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tables')
        .doc(id)
        .delete();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> addEnd({
    required int totalIncome,
    required String date,
  }) async {
    await FirebaseFirestore.instance.collection('Income').add({
      'date': date,
      'totalIncome': totalIncome,
    });
  }

  Future<void> add2(
      {required String tableNumber,
      required int v1,
      required int v2,
      required int v3,
      required int v4}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('orders')
        .add(
      {
        'Rum': v1,
        'Tequilla': v2,
        'Aperol': v3,
        'Whiskey': v4,
        'tablenumber': tableNumber,
      },
    );
  }

  Future<void> addBar(
      {required String tableNumber,
      required int v1,
      required int v2,
      required int v3,
      required int v4}) {
    return FirebaseFirestore.instance.collection('bar_orders').add(
      {
        'Rum': v1,
        'Tequilla': v2,
        'Aperol': v3,
        'Whiskey': v4,
        'tablenumber': tableNumber,
      },
    );
  }

  Future<void> removeBarOrder({required String id}) {
    return FirebaseFirestore.instance.collection('bar_orders').doc(id).delete();
  }

  Future<void> add({required String tableNumber}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tables')
        .add(
      {
        'number': tableNumber,
      },
    );
  }

  Future<void> addTotal({required int total, required String date}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('totals')
        .add(
      {
        'total': total,
        'date': date,
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
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception("User is not logged in");
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('orders')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ReciptModel(
              id: doc.id,
              v1: doc['Rum'],
              v2: doc['Tequilla'],
              v3: doc['Aperol'],
              v4: doc['Whiskey'],
              number: doc['tablenumber']);
        },
      ).toList();
    });
  }

  Stream<List<OrderModel>> getOrderModelStream() {
    return FirebaseFirestore.instance
        .collection('bar_orders')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return OrderModel(
              id: doc.id,
              v1: doc['Rum'],
              v2: doc['Tequilla'],
              v3: doc['Aperol'],
              v4: doc['Whiskey'],
              number: doc['tablenumber']);
        },
      ).toList();
    });
  }

  Future<void> removeOrder({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('user not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('orders')
        .doc(id)
        .delete();
  }

  Future<void> removeTotals({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('user not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('totals')
        .doc(id)
        .delete();
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //create account

  Future<User?> createUserWithEmailPass(String email, String password) async {
    try {
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user;
    } catch (error) {
      throw Exception(
        error.toString(),
      );
    }
  }

  //listening for authstate changes

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  //sign in with email and pass

  Future<User?> signInWithEmailPass(String email, String password) async {
    try {
      UserCredential authresult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authresult.user;
    } catch (error) {
      throw Exception(
        error.toString(),
      );
    }
  }

  //check sign in

  Future<bool> isSignedIn() async {
    User? currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
