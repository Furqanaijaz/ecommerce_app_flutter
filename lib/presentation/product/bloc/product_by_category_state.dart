import 'package:ecommerce_app/domain/product/entity/product.dart';

abstract class ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  List<ProductEntity> products;
  ProductByCategoryLoaded({required this.products});
}

class ProductByCategoryError extends ProductByCategoryState {
  final String error;

  ProductByCategoryError({required this.error});
}
