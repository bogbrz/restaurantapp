import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'root_page_state.dart';

class RootPageCubit extends Cubit<RootPageState> {
  RootPageCubit()
      : super(const RootPageState(
            user: null, isLoading: false, errorMessage: ''));

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const RootPageState(user: null, isLoading: true, errorMessage: ''),
    );
    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(RootPageState(user: user, isLoading: false, errorMessage: ''));
    })
          ..onError((error) {
            emit(RootPageState(
                user: null, isLoading: false, errorMessage: error.toString()));
          });
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      emit(RootPageState(
          user: null, isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> sigIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  Future<void> signOut() async {}

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
