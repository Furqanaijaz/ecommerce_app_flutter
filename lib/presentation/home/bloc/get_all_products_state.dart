import 'package:ecommerce_app/domain/product/entity/product.dart';

abstract class GetAllProductsState {}

class GetAllProductsLoadingState extends GetAllProductsState {}

class GetAllProductsLoadedState extends GetAllProductsState {
  final List<ProductEntity> products;

  GetAllProductsLoadedState({required this.products});
}

class GetAllProductsErrorState extends GetAllProductsState {
  final String errorMessage;

  GetAllProductsErrorState({required this.errorMessage});
}
