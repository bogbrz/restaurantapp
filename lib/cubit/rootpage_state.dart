part of 'rootpage_cubit.dart';

@immutable
class RootpageState {
  final User? user;
  final bool isLoading;
  final String errorMessage;
  const RootpageState({
    required this.user,
    required this.errorMessage,
    required this.isLoading,
  });
}
