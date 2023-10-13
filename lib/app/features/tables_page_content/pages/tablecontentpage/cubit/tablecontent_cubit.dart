import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

//a

part 'tablecontent_state.dart';

class TablecontentCubit extends Cubit<TablecontentState> {
  TablecontentCubit(this._tableRepository)
      : super(
          const TablecontentState(
            isLoading: false,
            tablePageModels: [],
            errorMessage: '',
          ),
        );
  final TableRepository _tableRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const TablecontentState(
        errorMessage: '', isLoading: false, tablePageModels: []));

    _streamSubscription =
        _tableRepository.getTableModelStream().listen((drinks) {
      emit(TablecontentState(
          errorMessage: '', isLoading: false, tablePageModels: drinks));
    })
          ..onError((error) {
            emit(const TablecontentState(
                errorMessage: "error fetching data",
                isLoading: false,
                tablePageModels: []));
          });
  }

  Future<void> add(String tableNumber, int v1, v2, v3, v4) async {
    try {
      await _tableRepository.add2(
          tableNumber: tableNumber, v1: v1, v2: v2, v3: v3, v4: v4);
    } catch (error) {
      emit(TablecontentState(
          errorMessage: error.toString(),
          isLoading: false,
          tablePageModels: const []));
    }
  }

  Future<void> addBar(String tableNumber, int v1, v2, v3, v4) async {
    try {
      await _tableRepository.addBar(
          tableNumber: tableNumber, v1: v1, v2: v2, v3: v3, v4: v4);
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
