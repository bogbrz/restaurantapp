import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurantapp/models/totalmodel.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

part 'myaccount_state.dart';

class MyaccountCubit extends Cubit<MyaccountState> {
  MyaccountCubit(this._tableRepository)
      : super(MyaccountState(totals: [], isLoading: false, errorMessage: ''));

  final TableRepository _tableRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _tableRepository.getTotalStream().listen((totals) {
      emit(MyaccountState(totals: totals, isLoading: false, errorMessage: ''));
    })
      ..onError((error) {
        emit(MyaccountState(
            totals: [], isLoading: false, errorMessage: error.toString()));
      });
  }

  Future<void> addEnd(
    int totalIncome,
    String date,
  ) async {
    await _tableRepository.addEnd(
      totalIncome: totalIncome,
      date: date,
    );
  }

  Future<void> removeEnd(String id) async {
    await _tableRepository.removeTotals(id: id);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
