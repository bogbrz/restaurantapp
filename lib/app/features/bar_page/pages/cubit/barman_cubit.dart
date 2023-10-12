import 'package:bloc/bloc.dart';

part 'barman_state.dart';

class BarmanCubit extends Cubit<BarmanState> {
  BarmanCubit() : super(BarmanState());
}
