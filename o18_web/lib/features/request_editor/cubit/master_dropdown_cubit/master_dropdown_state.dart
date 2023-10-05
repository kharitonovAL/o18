part of 'master_dropdown_cubit.dart';

abstract class MasterDropdownState extends Equatable {
  const MasterDropdownState();

  @override
  List<Object> get props => [];
}

class MasterDropdownInitial extends MasterDropdownState {}

class MasterDataLoading extends MasterDropdownState {}

class MasterDataLoaded extends MasterDropdownState {
  final List<Staff> masterList;

  const MasterDataLoaded(
    this.masterList,
  );

  @override
  List<Object> get props => [masterList];
}
