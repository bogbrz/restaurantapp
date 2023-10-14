import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantapp/models/tablemodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';
//a

part 'table_page_state.dart';

class TablePageCubit extends Cubit<TablePageState> {
  TablePageCubit(this._tableRepository)
      : super(const TablePageState(
            isLoading: false, errorMessage: '', tables: []));

  final TableRepository _tableRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _tableRepository.getTablesStream().listen((tables) {
      //KONWERTUJEMY DANE Z BAZY NA Table model .map((DOC) {} )  doc oznacza dokumenty z bazy danych a w {co ma zwrócić}

      emit(TablePageState(tables: tables, errorMessage: '', isLoading: false));
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
      await _tableRepository.add(tableNumber: tableNumber);
    } catch (error) {
      emit(TablePageState(
          tables: const [], errorMessage: error.toString(), isLoading: false));
    }
    start();
  }

  Future<void> remove(String documentId) async {
    try {
      await _tableRepository.remove(id: documentId);
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
