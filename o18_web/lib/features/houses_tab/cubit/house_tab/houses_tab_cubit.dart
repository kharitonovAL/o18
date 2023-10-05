import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/utils.dart';

part 'houses_tab_state.dart';

class HousesTabCubit extends Cubit<HousesTabState> {
  HousesTabCubit() : super(HousesTabInitial()) {
    loadHousesList();
  }

  List<House> houseList = [];
  final _houseRepository = HouseRepository();
  final _messagesRepository = MessagesRepository();

  Future<void> loadHousesList() async {
    emit(HousesLoading());
    final list = await _houseRepository.getHouseList();
    if (list.isNotEmpty) {
      list.sort((a, b) => a.addressToString.compareTo(b.addressToString));
      emit(HousesLoaded(list));

      houseList = list;
    } else {
      emit(const HousesLoadFailure(
        error: ErrorText.loadFailure,
      ));
    }
  }

  void searchHouse(
    String query,
  ) {
    final list = houseList;
    list.sort((a, b) => a.addressToString.compareTo(b.addressToString));

    final searchResultList = <House>[];

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((h) {
      if (h.addressToString.toLowerCase().contains(query.toLowerCase())) {
        searchResultList.add(h);
      }
    });

    emit(SearchingHouse(
      searchResultList,
    ));
  }

  Future<bool> sendNotification({
    required String message,
    required String houseId,
  }) async =>
      _messagesRepository.sendPushToTopic(
        body: message,
        houseId: houseId,
      );
}
