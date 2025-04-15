import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/product/entity/product.dart';

class CartState {
  final List<ProductEntity> items;

  CartState({required this.items});
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: []));

  void addToCart(ProductEntity product) {
    final existingIndex = state.items.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingIndex != -1) {
      final updatedList = List<ProductEntity>.from(state.items);
      final existingItem = updatedList[existingIndex];
      updatedList[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      emit(CartState(items: updatedList));
    } else {
      emit(CartState(items: [...state.items, product.copyWith(quantity: 1)]));
    }
  }

  void removeFromWishList(ProductEntity product) {
    final existingIndex = state.items.indexWhere(
      (item) => item.id == product.id,
    );
    if (existingIndex != -1) {
      final updatedList = List<ProductEntity>.from(state.items);
      final existingItem = updatedList[existingIndex];
      if (existingItem.quantity > 1) {
        updatedList[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedList.removeAt(existingIndex);
      }
      emit(CartState(items: updatedList));
    }
  }

  int get totalItemsCount =>
      state.items.fold(0, (sum, item) => sum + item.quantity);
}
