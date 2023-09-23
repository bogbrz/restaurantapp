part of 'table_page_cubit.dart';

@immutable
class TablePageState {
  final bool isLoading;
  final String errorMessage;
  final List<QueryDocumentSnapshot<Object?>> documents;
  const TablePageState({
    required this.documents,
    required this.errorMessage,
    required this.isLoading,
  });
}
