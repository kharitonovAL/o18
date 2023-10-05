import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_page_state.dart';

class TabPageCubit extends Cubit<TabPageState> {
  TabPageCubit() : super(TabPageInitial());
}
