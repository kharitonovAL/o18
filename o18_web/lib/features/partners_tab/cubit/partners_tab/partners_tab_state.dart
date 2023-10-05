part of 'partners_tab_cubit.dart';

abstract class PartnersTabState extends Equatable {
  const PartnersTabState();

  @override
  List<Object> get props => [];
}

class PartnersTabInitial extends PartnersTabState {}

class PartnersLoading extends PartnersTabState {}

class PartnersLoaded extends PartnersTabState {
  final List<Partner> list;

  const PartnersLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class PartnersLoadFailed extends PartnersTabState {
  final String error;

  const PartnersLoadFailed({
    required this.error,
  });

  @override
  String toString() => 'PartnersLoadFailed { error: $error }';
}

class SearchingPartner extends PartnersTabState {
  final List<Partner> list;

  const SearchingPartner(
    this.list,
  );

  @override
  List<Object> get props => [list];
}