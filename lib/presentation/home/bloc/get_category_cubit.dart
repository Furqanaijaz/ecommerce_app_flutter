import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/domain/category/usecase/get_category.dart';
import 'package:ecommerce_app/presentation/home/bloc/get_category_state.dart';
import 'package:ecommerce_app/service_locator.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  GetCategoryCubit() : super(CategoryLoadingState());

  void getCategories() async {
    var categories = await sl<GetCategoryUseCase>().call();
    categories.fold(
      (error) {
        emit(CategoryErrorState(error: error));
      },
      (data) {
        emit(CategoryLoadedState(categories: data));
      },
    );
  }
}
