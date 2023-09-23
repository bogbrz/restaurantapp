import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'table_page_state.dart';

class TablePageCubit extends Cubit<TablePageState> {
  TablePageCubit()
      : super(const TablePageState(
            isLoading: false, errorMessage: '', documents: []));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const TablePageState(
        documents: [], errorMessage: ' ', isLoading: true));

    _streamSubscription = FirebaseFirestore.instance
        .collection('tables')
        .orderBy("number", descending: false)
        .snapshots()
        .listen((data) {
      emit(TablePageState(
          documents: data.docs, errorMessage: '', isLoading: false));
    })
      ..onError((error) {
        emit(TablePageState(
            documents: const [],
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
          documents: const [],
          errorMessage: error.toString(),
          isLoading: false));
    }
  }

  Future<void> remove(String documentId) async {
    try {
      FirebaseFirestore.instance.collection('tables').doc(documentId).delete();
    } catch (error) {
      emit(TablePageState(
          documents: const [],
          errorMessage: error.toString(),
          isLoading: false));
    }
    start();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
