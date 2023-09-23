import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'rootpage_state.dart';

class RootpageCubit extends Cubit<RootpageState> {
  RootpageCubit()
      : super(const RootpageState(
          user: null,
          isLoading: false,
          errorMessage: '',
        ));

      StreamSubscription? _streamSubscription;
      Future<void> start() async {
     emit( const RootpageState(user: null, errorMessage: '', isLoading: true))
     }

     Future<void> signIn(String email, String password) async{
      try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password);
                  } catch (error) {
                    emit(RootpageState(user: null, errorMessage: error.toString(), isLoading: true),);
                  }
     }

      Future<void> createAccount(String email, String password) async{
      try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password);
                  } catch (error) {
                    emit(RootpageState(user: null, errorMessage: error.toString(), isLoading: true));
                    };
                  }



  
  }

