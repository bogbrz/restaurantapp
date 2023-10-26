import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:restaurantapp/models/pricemodel.dart';
import 'package:restaurantapp/data_source_repositories/repositories/table_repository.dart';

part 'pricemodel_state.dart';

class PricemodelCubit extends Cubit<PricemodelState> {
  PricemodelCubit(this._tableRepository)
      : super(
          PricemodelState(
            isLoading: false,
            errorMessage: '',
            pricies: [],
          ),
        );

  final TableRepository _tableRepository;
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    _streamSubscription = _tableRepository.getPriceStream().listen((prices) {
      emit(
        PricemodelState(
          pricies: prices,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          PricemodelState(
            isLoading: false,
            errorMessage: error.toString(),
            pricies: [],
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
