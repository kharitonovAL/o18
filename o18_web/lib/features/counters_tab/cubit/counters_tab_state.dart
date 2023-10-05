part of 'counters_tab_cubit.dart';

abstract class CountersTabState extends Equatable {
  const CountersTabState();

  @override
  List<Object> get props => [];
}

class CountersTabInitial extends CountersTabState {}

class CountersTabLoading extends CountersTabState {}

class CountersTabLoaded extends CountersTabState {
  final List<Counter> list;

  const CountersTabLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class CountersTabLoadFailed extends CountersTabState {
  final String error;

  const CountersTabLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class CurrentMonth extends CountersTabState {
  final List<Counter> list;

  const CurrentMonth(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class SearchingCounter extends CountersTabState {
  final List<Counter> list;

  const SearchingCounter(
    this.list,
  );

  @override
  List<Object> get props => [list];
}
