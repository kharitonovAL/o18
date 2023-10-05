import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'partner_dropdown_state.dart';

class PartnerDropdownCubit extends Cubit<PartnerDropdownState> {
  PartnerDropdownCubit() : super(PartnerDropdownInitial()) {
    loadPartnerData();
  }

  final _partnerRepository = PartnerRepository();

  Future<void> loadPartnerData() async {
    emit(PartnerDataLoading());
    final partnerList = await _partnerRepository.getPartnerList();
    emit(PartnerDataLoaded(partnerList));
  }
}
