import 'package:ecommerce_app/domain/product/usecase/get_all_products.dart';
import 'package:ecommerce_app/presentation/home/bloc/get_all_products_state.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit() : super(GetAllProductsLoadingState());
  void getAllProducts() async {
    var returnData = await sl<GetAllProductsUseCase>().call();
    returnData.fold(
      (error) {
        emit(GetAllProductsErrorState(errorMessage: error.toString()));
      },
      (data) {
        emit(GetAllProductsLoadedState(products: data));
      },
    );
  }
}
