part of 'pricemodel_cubit.dart';

class PricemodelState {
  final List<PriceModel> pricies;
  final bool isLoading;
  final String errorMessage;

  PricemodelState(
      {required this.isLoading,
      required this.errorMessage,
      required this.pricies});
}
