part of 'partner_dropdown_cubit.dart';

abstract class PartnerDropdownState extends Equatable {
  const PartnerDropdownState();

  @override
  List<Object> get props => [];
}

class PartnerDropdownInitial extends PartnerDropdownState {}

class PartnerDataLoading extends PartnerDropdownState {}

class PartnerDataLoaded extends PartnerDropdownState {
  final List<Partner> partnerList;

  const PartnerDataLoaded(
    this.partnerList,
  );

  @override
  List<Object> get props => [partnerList];
}
