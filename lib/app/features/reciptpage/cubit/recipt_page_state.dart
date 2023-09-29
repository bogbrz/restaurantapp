part of 'recipt_page_cubit.dart';

@immutable
class ReciptPageState {
  final bool isLoading;
  final String errorMessage;
  final List<ReciptModel> recipts;
  const ReciptPageState({
    required this.isLoading,
    required this.errorMessage,
    required this.recipts,
  });
}
