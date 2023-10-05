import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'counters_tab_state.dart';

class CountersTabCubit extends Cubit<CountersTabState> {
  CountersTabCubit() : super(CountersTabInitial()) {
    loadCounters();
  }

  List<Counter> counterList = [];
  final _counterRepository = CounterRepository();

  Future<void> loadCounters() async {
    emit(CountersTabLoading());

    final list = await _counterRepository.getCounterList();
    list.sort((a, b) => a.serviceTitle!.compareTo(b.serviceTitle!));

    counterList = list.toList();

    emit(CountersTabLoaded(list));
  }

  void searchCounter(
    String query,
  ) {
    final list = counterList.toList();
    final searchResultList = <Counter>[];

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((c) {
      if (c.address!.toLowerCase().contains(query.toLowerCase()) ||
          c.serialNumber!.toLowerCase().contains(query.toLowerCase()) ||
          c.serviceTitle!.contains(query.toLowerCase())) {
        searchResultList.add(c);
      }
    });

    emit(SearchingCounter(
      searchResultList,
    ));
  }

  void currentMonth({
    required bool currentMonthOnly,
  }) {
    final fullList = counterList.toList();
    final monthList = counterList.toList();
    monthList.retainWhere(
      (counter) => counter.currentReadingDate!.month == DateTime.now().month,
    );

    emit(CurrentMonth(
      currentMonthOnly ? monthList : fullList,
    ));
  }
}
