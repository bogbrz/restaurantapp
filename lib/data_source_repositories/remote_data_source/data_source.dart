import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataSource {
  Stream<QuerySnapshot> getTablesStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tables')
        .orderBy('number', descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getPriceStream() {
    return FirebaseFirestore.instance.collection('prices').snapshots();
  }

  Stream<QuerySnapshot> getIncomeStream() {
    return FirebaseFirestore.instance
        .collection('Income')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getTotalStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('totals')
        .snapshots();
  }

  Stream<QuerySnapshot> getTableModelStream() {
    return FirebaseFirestore.instance.collection('drinks').snapshots();
  }

  Stream<QuerySnapshot> getReciptModelStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception("User is not logged in");
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('orders')
        .snapshots();
  }

  Stream<QuerySnapshot> getOrderModelStream() {
    return FirebaseFirestore.instance.collection('bar_orders').snapshots();
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

  Future<User?> createUserWithEmailPass(String email, String password) async {
    try {
      UserCredential authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

  Future<User?> signInWithEmailPass(String email, String password) async {
    try {
      UserCredential authresult =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();
}
