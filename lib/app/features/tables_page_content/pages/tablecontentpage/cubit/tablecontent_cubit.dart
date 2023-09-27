import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantapp/models/tablepagemodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

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

  Future<void> remove(String documentId) async {
    try {
      await _tableRepository.removeDrink(id: documentId);
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
