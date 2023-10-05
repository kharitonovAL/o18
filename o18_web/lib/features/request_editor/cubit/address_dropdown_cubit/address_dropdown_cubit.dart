import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'address_dropdown_state.dart';

class AddressDropdownCubit extends Cubit<AddressDropdownState> {
  AddressDropdownCubit() : super(AddressDropdownInitial()) {
    loadHouseData();
  }

  final _houseRepository = HouseRepository();

  Future<void> loadHouseData() async {
    emit(AddressDataLoading());
    final houseList = await _houseRepository.getHouseList();
    emit(AddressDataLoaded(
      houseList: houseList,
    ));
  }
}
