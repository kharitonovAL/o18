part of 'houses_tab_cubit.dart';

abstract class HousesTabState extends Equatable {
  const HousesTabState();

  @override
  List<Object> get props => [];
}

class HousesTabInitial extends HousesTabState {
  @override
  String toString() => 'HousesTabInitial';
}

class HousesLoading extends HousesTabState {
  @override
  String toString() => 'HousesLoading';
}

class HousesLoaded extends HousesTabState {
  final List<House> houseList;

  const HousesLoaded(
    this.houseList,
  );

  @override
  String toString() => 'HousesLoadedSuccessfully';

  @override
  List<Object> get props => [houseList];
}

class HousesLoadFailure extends HousesTabState {
  final String error;

  const HousesLoadFailure({
    required this.error,
  });

  @override
  String toString() => 'HousesLoadFailure { error: $error }';
}

class SearchingHouse extends HousesTabState {
  final List<House> houseList;

  const SearchingHouse(
    this.houseList,
  );

  @override
  String toString() => 'SearchchingHouse';

  @override
  List<Object> get props => [houseList];
}
