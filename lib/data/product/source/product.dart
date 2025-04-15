import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/dio_clint.dart';
import 'package:ecommerce_app/service_locator.dart';

abstract class ProductSource {
  Future<Either> getAllProducts();
  Future<Either> searchProducts(String query);
  Future<Either> getProductsbycategory(String url);
}

class ProductSourceImpl extends ProductSource {
  @override
  Future<Either> getAllProducts() async {
    try {
      var response = await Dio().get("https://dummyjson.com/products");

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> searchProducts(String query) async {
    try {
      var response = await sl<DioClient>().get(
        "https://dummyjson.com/products/search?q=$query",
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getProductsbycategory(String url) async {
    try {
      var response = await sl<DioClient>().get(
        "https://dummyjson.com/products/category/$url",
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
