part of 'address_dropdown_cubit.dart';

abstract class AddressDropdownState extends Equatable {
  const AddressDropdownState();

  @override
  List<Object> get props => [];
}

class AddressDropdownInitial extends AddressDropdownState {}

class AddressDataLoading extends AddressDropdownState {}

class AddressDataLoaded extends AddressDropdownState {
  final List<House> houseList;

  const AddressDataLoaded({
    required this.houseList,
  });

  @override
  List<Object> get props => [houseList];
}
