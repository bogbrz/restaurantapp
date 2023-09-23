part of 'tablepage_cubit.dart';

@immutable
class TablepageState {
  final List<QuerySnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;
  const TablepageState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
