import 'package:ecommerce_app/domain/product/usecase/get_product_by_category.dart';
import 'package:ecommerce_app/presentation/product/bloc/product_by_category_state.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState> {
  ProductByCategoryCubit() : super(ProductByCategoryLoading());
  void getProductByCategory(String url) async {
    var returnData = await sl<GetProductByCategoryUseCase>().call(params: url);

    returnData.fold(
      (eror) {
        emit(ProductByCategoryError(error: eror.toString()));
      },
      (data) {
        emit(ProductByCategoryLoaded(products: data));
      },
    );
  }
}
