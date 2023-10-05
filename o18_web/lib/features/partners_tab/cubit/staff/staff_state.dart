part of 'staff_cubit.dart';

abstract class StaffState extends Equatable {
  const StaffState();

  @override
  List<Object> get props => [];
}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<Staff> list;

  const StaffLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class StaffLoadFailed extends StaffState {
  final String error;

  const StaffLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class StaffAdded extends StaffState {}

class StaffAddFailed extends StaffState {
  final String error;

  const StaffAddFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class StaffUpdated extends StaffState {}

class StaffUpdateFailed extends StaffState {
  final String error;

  const StaffUpdateFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class StaffDeleted extends StaffState {}

class StaffDeleteFailed extends StaffState {
  final String error;

  const StaffDeleteFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}
