import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'flat_list_state.dart';

class FlatListCubit extends Cubit<FlatListState> {
  final House house;

  FlatListCubit({
    required this.house,
  }) : super(FlatListInitial()) {
    loadFlatList();
  }

  final _flatRepository = FlatRepository();

  Future<void> loadFlatList() async {
    emit(FlatListLoading());

    final list = await _flatRepository.getFlatListForHouse(
      houseId: house.objectId!,
    );

    emit(FlatListLoaded(list));
  }

  Future<bool> saveChanges({
    required Flat flat,
    required String flatNumber,
    required double square,
    required int numberOfResidents,
    required String? purpose,
  }) async {
    flat
      ..flatNumber = flatNumber
      ..flatSquare = square
      ..numberOfResidents = numberOfResidents
      ..purpose = purpose;

    final result = await flat.update();

    return result.success;
  }
}
