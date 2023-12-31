import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:restaurantapp/models/incomemodel.dart';
import 'package:restaurantapp/data_source_repositories/repositories/table_repository.dart';

part 'barmanaccount_state.dart';

class BarmanAccountCubit extends Cubit<BarmanAccountState> {
  BarmanAccountCubit(this._tableRepository)
      : super(
          const BarmanAccountState(
            isLoading: false,
            errorMessage: '',
            income: [],
            incomeModel: null,
          ),
        );
  final TableRepository _tableRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _tableRepository.getIncomeStream().listen((income) {
      emit(
        BarmanAccountState(
            isLoading: false,
            errorMessage: '',
            income: income,
            incomeModel: null),
      );
    })
      ..onError((error) {
        emit(
          BarmanAccountState(
              isLoading: false,
              errorMessage: error.toString(),
              income: [],
              incomeModel: null),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
