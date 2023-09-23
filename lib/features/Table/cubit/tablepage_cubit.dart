import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'tablepage_state.dart';

class TablepageCubit extends Cubit<TablepageState> {
  TablepageCubit()
      : super(const TablepageState(
            isLoading: false, errorMessage: '', document: []));

  Future<void> start() async {
    emit(
      const TablepageState(
        document: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
  }
}
