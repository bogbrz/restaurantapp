part of 'barmanaccount_cubit.dart';

class BarmanAccountState {
  final bool isLoading;
  final String errorMessage;
  final IncomeModel? incomeModel;

  final List<IncomeModel> income;
  const BarmanAccountState({
    required this.isLoading,
    required this.errorMessage,
    required this.income,
    required this.incomeModel,
  });
}
