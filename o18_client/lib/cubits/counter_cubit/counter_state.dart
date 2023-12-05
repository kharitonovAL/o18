part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {
  @override
  String toString() => 'CounterInitial';
}

class CounterLoading extends CounterState {
  @override
  String toString() => 'CounterLoading';
}

class CounterLoaded extends CounterState {
  final List<Counter> counterList;

  const CounterLoaded(this.counterList);

  @override
  String toString() => 'CounterLoaded';

  @override
  List<Object> get props => [counterList];
}

class CounterLoadFailure extends CounterState {
  final String error;

  const CounterLoadFailure({required this.error});

  @override
  String toString() => 'CounterLoadFailure { error: $error }';
}

class CounterReadingsAdded extends CounterState {
  final List<Counter> counterList;

  const CounterReadingsAdded(this.counterList);

  @override
  String toString() => 'CounterReadingsAdded';

  @override
  List<Object> get props => [counterList];
}

