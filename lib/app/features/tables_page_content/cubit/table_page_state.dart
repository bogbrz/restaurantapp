part of 'table_page_cubit.dart';

@immutable
class TablePageState {
  final bool isLoading;
  final String errorMessage;
  final List<TableModel> tables;
  const TablePageState({
    required this.tables,
    required this.errorMessage,
    required this.isLoading,
  });
}
