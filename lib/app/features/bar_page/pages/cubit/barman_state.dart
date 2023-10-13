part of 'barman_cubit.dart';

class BarmanState {
  final bool isLoading;
  final String errorMessage;
  final List<OrderModel> orders;
  const BarmanState({
    required this.isLoading,
    required this.errorMessage,
    required this.orders,
  });
}
