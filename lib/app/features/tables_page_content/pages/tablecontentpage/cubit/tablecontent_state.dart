part of 'tablecontent_cubit.dart';

@immutable
class TablecontentState {
  final bool isLoading;
  final String errorMessage;
  final List<TablePageModel> tablePageModels;
  const TablecontentState(
      {required this.errorMessage,
      required this.isLoading,
      required this.tablePageModels});
}
