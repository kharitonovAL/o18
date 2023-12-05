part of 'tab_bar_cubit.dart';

abstract class TabBarState extends Equatable {
  const TabBarState();

  @override
  List<Object> get props => [];
}

class TabBarInitial extends TabBarState {
  @override
  String toString() => 'TabBarInitial';
}

class TabBarFailure extends TabBarState {
  final String error;

  const TabBarFailure({required this.error});

  @override
  String toString() => 'TabBarFailure { error: $error }';
}
