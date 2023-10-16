import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';
import 'package:restaurantapp/repositories/table_repository.dart';

part 'root_page_state.dart';

class RootPageCubit extends Cubit<RootPageState> {
  RootPageCubit(
    this._tableRepository,
  ) : super(const RootPageState(
            user: null, isLoading: false, errorMessage: ''));

  final TableRepository _tableRepository;

  late StreamSubscription<User?> _streamSubscription;
  Future<void> start() async {
    emit(
      const RootPageState(user: null, isLoading: true, errorMessage: ''),
    );
    _streamSubscription = _tableRepository.authStateChanges.listen(
      (user) {
        emit(
          RootPageState(
            user: user,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError((error) {
        emit(RootPageState(
            user: null, isLoading: false, errorMessage: error.toString()));
      });
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await _tableRepository.createUserWithEmailPass(email, password);
    } catch (error) {
      emit(RootPageState(
          user: null, isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> sigIn(String email, String password) async {
    try {
      await _tableRepository.signInWithEmailPass(email, password);
    } catch (error) {
      emit(
        RootPageState(
          user: null,
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    await _tableRepository.signOut();
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
