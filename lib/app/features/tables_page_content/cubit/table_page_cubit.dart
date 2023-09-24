import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:restaurantapp/models/tablemodel.dart';

part 'table_page_state.dart';

class TablePageCubit extends Cubit<TablePageState> {
  TablePageCubit()
      : super(const TablePageState(
            isLoading: false, errorMessage: '', tables: []));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const TablePageState(tables: [], errorMessage: '', isLoading: true));

    _streamSubscription = FirebaseFirestore.instance
        .collection('tables')
        .orderBy("number", descending: false)
        .snapshots()
        .listen((tables) {
      //KONWERTUJEMY DANE Z BAZY NA Table model .map((DOC) {} )  doc oznacza dokumenty z bazy danych a w {co ma zwrócić}
      final tableModels = tables.docs.map((doc) {
        return TableModel(id: doc.id, number: doc['number']);
      }).toList();
      emit(TablePageState(
          tables: tableModels, errorMessage: '', isLoading: false));
    })
      ..onError((error) {
        emit(TablePageState(
            tables: const [],
            errorMessage: error.toString(),
            isLoading: false));
      });
  }

  Future<void> add(String tableNumber) async {
    try {
      FirebaseFirestore.instance
          .collection('tables')
          .add({'number': tableNumber});
    } catch (error) {
      emit(TablePageState(
          tables: const [], errorMessage: error.toString(), isLoading: false));
    }
    start();
  }

  Future<void> remove(String documentId) async {
    try {
      FirebaseFirestore.instance.collection('tables').doc(documentId).delete();
    } catch (error) {
      emit(TablePageState(
          tables: const [], errorMessage: error.toString(), isLoading: false));
    }
    start();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
