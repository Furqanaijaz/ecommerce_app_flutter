import 'package:ecommerce_app/common/bottom_navigation/bloc/bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(selectedIndex: 0));
  selectedIndex(int index) => emit(BottomNavigationState(selectedIndex: index));
}
