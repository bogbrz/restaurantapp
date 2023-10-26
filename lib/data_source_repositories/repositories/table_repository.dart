import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurantapp/data_source_repositories/remote_data_source/data_source.dart';
import 'package:restaurantapp/models/incomemodel.dart';
import 'package:restaurantapp/models/ordermodel.dart';
import 'package:restaurantapp/models/pricemodel.dart';
import 'package:restaurantapp/models/reciptmodel.dart';
import 'package:restaurantapp/models/tablemodel.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';
import 'package:restaurantapp/models/totalmodel.dart';

class TableRepository {
  TableRepository(this._dataSource);

  final DataSource _dataSource;

  Stream<List<TableModel>> getTablesStream() {
    return _dataSource.getTablesStream().map((quersnapshot) => quersnapshot.docs
        .map(
          (doc) => TableModel(
            id: doc.id,
            number: doc['number'],
          ),
        )
        .toList());
  }

  Stream<List<PriceModel>> getPriceStream() {
    return _dataSource.getPriceStream().map((querysnapshot) => querysnapshot
        .docs
        .map((doc) => PriceModel(
            price1: doc['price1'],
            price2: doc['price2'],
            price3: doc['price3'],
            price4: doc['price4']))
        .toList());
  }

  Stream<List<IncomeModel>> getIncomeStream() {
    return _dataSource.getIncomeStream().map((querysnapshot) => querysnapshot
        .docs
        .map((doc) => IncomeModel(
            totalIncome: doc['totalIncome'], id: doc.id, date: doc['date']))
        .toList());
  }

  Stream<List<TotalModel>> getTotalStream() {
    return _dataSource.getTotalStream().map((querysnapshot) => querysnapshot
        .docs
        .map((doc) =>
            TotalModel(total: doc['total'], id: doc.id, date: doc['date']))
        .toList());
  }

  Stream<List<TablePageModel>> getTableModelStream() {
    return _dataSource.getTableModelStream().map((querysnapshot) =>
        querysnapshot.docs
            .map((doc) => TablePageModel(name: doc['name'], id: doc.id))
            .toList());
  }

  Stream<List<ReciptModel>> getReciptModelStream() {
    return _dataSource.getReciptModelStream().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => ReciptModel(
                id: doc.id,
                v1: doc['Rum'],
                v2: doc['Tequilla'],
                v3: doc['Aperol'],
                v4: doc['Whiskey'],
                number: doc['tablenumber']))
            .toList());
  }

  Stream<List<OrderModel>> getOrderModelStream() {
    return _dataSource.getOrderModelStream().map((querysnapshot) =>
        querysnapshot.docs
            .map((doc) => OrderModel(
                id: doc.id,
                v1: doc['Rum'],
                v2: doc['Tequilla'],
                v3: doc['Aperol'],
                v4: doc['Whiskey'],
                number: doc['tablenumber']))
            .toList());
  }

  Future<void> remove({required String id}) {
    return _dataSource.remove(id: id);
  }

  Future<void> signOut() async {
    return _dataSource.signOut();
  }

  Future<void> addEnd({
    required int totalIncome,
    required String date,
  }) async {
    _dataSource.addEnd(totalIncome: totalIncome, date: date);
  }

  Future<void> add2(
      {required String tableNumber,
      required int v1,
      required int v2,
      required int v3,
      required int v4}) {
    return _dataSource.add2(
        tableNumber: tableNumber, v1: v1, v2: v2, v3: v3, v4: v4);
  }

  Future<void> addBar(
      {required String tableNumber,
      required int v1,
      required int v2,
      required int v3,
      required int v4}) {
    return _dataSource.addBar(
        tableNumber: tableNumber, v1: v1, v2: v2, v3: v3, v4: v4);
  }

  Future<void> removeBarOrder({required String id}) {
    return _dataSource.remove(id: id);
  }

  Future<void> add({required String tableNumber}) {
    return _dataSource.add(tableNumber: tableNumber);
  }

  Future<void> addTotal({required int total, required String date}) {
    return _dataSource.addTotal(total: total, date: date);
  }

  Future<void> removeOrder({required String id}) {
    return _dataSource.removeOrder(id: id);
  }

  Future<void> removeTotals({required String id}) {
    return _dataSource.removeTotals(id: id);
  }

  //create account

  Future<User?> createUserWithEmailPass(String email, String password) async {
    return _dataSource.createUserWithEmailPass(email, password);
  }

  //listening for authstate changes

  Stream<User?> get authStateChanges => _dataSource.authStateChanges;

  //sign in with email and pass

  Future<User?> signInWithEmailPass(String email, String password) async {
    return _dataSource.signInWithEmailPass(email, password);
  }
}
