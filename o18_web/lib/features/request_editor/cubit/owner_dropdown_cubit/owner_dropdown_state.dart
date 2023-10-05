part of 'owner_dropdown_cubit.dart';

abstract class OwnerDropdownState extends Equatable {
  const OwnerDropdownState();

  @override
  List<Object> get props => [];
}

class OwnerDropdownInitial extends OwnerDropdownState {}

class OwnerDataLoading extends OwnerDropdownState {}

class OwnerDataLoaded extends OwnerDropdownState {
  final List<Owner> ownerList;

  const OwnerDataLoaded(
    this.ownerList,
  );

  @override
  List<Object> get props => [ownerList];
}

class OwnerDataError extends OwnerDropdownState {}
