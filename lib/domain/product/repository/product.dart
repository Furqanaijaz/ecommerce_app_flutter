import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/product/model/products_model.dart';
import 'package:ecommerce_app/domain/product/entity/product.dart';

abstract class ProductRepository {
  Future<Either> getAllProducts();
  Future<Either> getSimilarProducts(ProductEntity product);

  Future<Either> searchProducts(String query);
  Future<Either> getProductsbycategory(String url);
}
