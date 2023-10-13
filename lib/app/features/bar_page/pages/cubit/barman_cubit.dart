import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:restaurantapp/models/ordermodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

part 'barman_state.dart';

class BarmanCubit extends Cubit<BarmanState> {
  BarmanCubit(this._tableRepository)
      : super(
            const BarmanState(isLoading: false, errorMessage: '', orders: []));

  final TableRepository _tableRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _tableRepository.getOrderModelStream().listen(
      (orders) {
        emit(
          BarmanState(
            isLoading: false,
            errorMessage: '',
            orders: orders,
          ),
        );
      },
    );
  }

  Future<void> removeBarOder(String barOderId) async {
    _tableRepository.removeBarOrder(id: barOderId);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
