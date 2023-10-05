part of 'list_sorting_cubit_cubit.dart';

class SortingState extends Equatable {
  final String sorting;

  const SortingState({
    this.sorting = 'Сначала новые',
  });

  @override
  List<Object> get props => [
        sorting,
      ];

  SortingState copyWith({
    String? sorting,
  }) =>
      SortingState(
        sorting: sorting ?? this.sorting,
      );
}
