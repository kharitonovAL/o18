part of 'staff_dropdown_cubit.dart';

abstract class StaffDropdownState extends Equatable {
  const StaffDropdownState();

  @override
  List<Object> get props => [];
}

class StaffDropdownInitial extends StaffDropdownState {}

class StaffDataLoading extends StaffDropdownState {}

class StaffDataLoaded extends StaffDropdownState {
  final List<Staff> staffList;

  const StaffDataLoaded(
    this.staffList,
  );

  @override
  List<Object> get props => [staffList];
}
