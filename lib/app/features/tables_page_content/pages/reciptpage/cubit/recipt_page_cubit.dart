import 'dart:async';

import 'package:bloc/bloc.dart';
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

  Future<void> removeOrder(String orderId) async {
    try {
      await _tableRepository.removeOrder(id: orderId);
    } catch (error) {
      emit(
        ReciptPageState(
          isLoading: false,
          errorMessage: error.toString(),
          recipts: [],
        ),
      );
    }
  }

  Future<void> addTotal(int total) async {
    try {
      await _tableRepository.addTotal(total: total);
    } catch (error) {
      emit(ReciptPageState(
          recipts: const [], errorMessage: error.toString(), isLoading: false));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
