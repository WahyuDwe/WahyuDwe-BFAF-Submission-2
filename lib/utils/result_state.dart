enum StatusState { loading, noData, hasData, error, textFieldEmpty }

class ResultState<T> {
  final StatusState status;
  final T? data;
  final String? message;

  ResultState({required this.status, this.data, this.message});
}