import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';

part 'tablecontent_state.dart';

class TablecontentCubit extends Cubit<TablecontentState> {
  TablecontentCubit()
      : super(
          const TablecontentState(
            isLoading: false,
            tablePageModels: [],
            errorMessage: '',
          ),
        );
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const TablecontentState(
        errorMessage: '', isLoading: false, tablePageModels: []));

    _streamSubscription = FirebaseFirestore.instance
        .collection('drinks')
        .snapshots()
        .listen((drinks) {
      final tableModels = drinks.docs.map((doc) {
        return TablePageModel(name: doc['name'].toString(), id: doc.id);
      }).toList();
      emit(TablecontentState(
          errorMessage: '', isLoading: false, tablePageModels: tableModels));
    })
      ..onError((error) {
        emit(const TablecontentState(
            errorMessage: "error fetching data",
            isLoading: false,
            tablePageModels: []));
      });
  }

  Future<void> remove(String documentId) async {
    try {
      FirebaseFirestore.instance.collection('drinks').doc(documentId).delete();
    } catch (error) {
      emit(TablecontentState(
          errorMessage: error.toString(),
          isLoading: false,
          tablePageModels: const []));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
