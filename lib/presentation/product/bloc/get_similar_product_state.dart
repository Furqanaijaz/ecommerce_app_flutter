import 'package:ecommerce_app/domain/product/entity/product.dart';

abstract class GetSimilarProductState {}

class SimilarProductLoading extends GetSimilarProductState {}

class SimilarProductLoaded extends GetSimilarProductState {
  final List<ProductEntity> product;

  SimilarProductLoaded({required this.product});
}

class SimilarProductError extends GetSimilarProductState {
  final String error;

  SimilarProductError({required this.error});
}
