import 'package:ecommerce_app/domain/product/entity/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<List<ProductEntity>> {
  WishlistCubit() : super([]);

  void addToWishList(ProductEntity product) {
    if (!state.contains(product)) {
      emit([...state, product]);
    }
  }

  void removeFromWishList(ProductEntity product) {
    emit(state.where((item) => item.id != product.id).toList());
  }

  bool isInWishList(ProductEntity product) {
    return state.contains(product);
  }
}
