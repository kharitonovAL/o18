import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_sorting_cubit_state.dart';

class SortingCubit extends Cubit<SortingState> {
  SortingCubit() : super(const SortingState()) {
    selectSorting('Сначала новые');
  }

  void selectSorting(String sorting) {
    emit(state.copyWith(
      sorting: sorting,
    ));
  }
}
