import 'package:ecommerce_app/domain/product/usecase/search_product_usecase.dart';
import 'package:ecommerce_app/presentation/search/bloc/search_product_state.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  SearchProductCubit() : super(SearchProductInitialState());

  void searchProduct(String query) async {
    if (query.isEmpty) {
      emit(SearchProductInitialState());
    }
    emit(SearchProductLoadingState());
    var returnData = await sl<SearchProductUsecase>().call(params: query);
    returnData.fold(
      (error) {
        emit(SearchProductErrorState(error: error.toString()));
      },
      (data) {
        emit(SearchProductLoadedState(products: data));
      },
    );
  }
}
