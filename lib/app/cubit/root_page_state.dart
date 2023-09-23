part of 'root_page_cubit.dart';

@immutable
class RootPageState {
  final User? user;
  final bool isLoading;
  final String errorMessage;
  const RootPageState({
    required this.user,
    required this.isLoading,
    required this.errorMessage,
  });
}
