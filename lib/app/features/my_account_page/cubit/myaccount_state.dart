part of 'myaccount_cubit.dart';

class MyaccountState {
  final List<TotalModel> totals;
  final bool isLoading;
  final String errorMessage;

  MyaccountState(
      {required this.totals,
      required this.errorMessage,
      required this.isLoading});
}
