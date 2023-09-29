import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurantapp/models/reciptmodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

part 'recipt_page_state.dart';

class ReciptPageCubit extends Cubit<ReciptPageState> {
  ReciptPageCubit(this._tableRepository)
      : super(const ReciptPageState(
            isLoading: false, errorMessage: '', recipts: []));
  final TableRepository _tableRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const ReciptPageState(isLoading: true, errorMessage: '', recipts: []));
    _streamSubscription =
        _tableRepository.getReciptModelStream().listen((recipts) {
      emit(ReciptPageState(
          isLoading: false, errorMessage: '', recipts: recipts));
    })
          ..onError((error) {
            emit(ReciptPageState(
                isLoading: false,
                errorMessage: error.toString(),
                recipts: const []));
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
