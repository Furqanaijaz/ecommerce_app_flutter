// user_cubit.dart
import 'package:ecommerce_app/domain/auth/usecase/get_userdata.dart';
import 'package:ecommerce_app/presentation/auth/bloc/userdata_state.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> fetchUser() async {
    if (state is UserLoaded) return; // already fetched
    emit(UserLoading());
    var getUserData = await sl<GetUserdataUseCase>().call();
    getUserData.fold(
      (error) => emit(UserError(error)),
      (user) => emit(UserLoaded(user)),
    );
  }
}
