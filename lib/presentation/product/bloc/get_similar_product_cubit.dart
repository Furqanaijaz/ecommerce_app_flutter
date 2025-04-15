import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:ecommerce_app/domain/product/usecase/get_simila_products.dart';
import 'package:ecommerce_app/presentation/product/bloc/get_similar_product_state.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetSimilarProductCubit extends Cubit<GetSimilarProductState> {
  GetSimilarProductCubit() : super(SimilarProductLoading());
  void getSimilarProducts(ProductEntity product) async {
    var returnData = await sl<GetSimilaProductsUseCase>().call(params: product);
    returnData.fold(
      (error) {
        emit(SimilarProductError(error: error));
      },
      (data) {
        emit(SimilarProductLoaded(product: data));
      },
    );
  }
}
