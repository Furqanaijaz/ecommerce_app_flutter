import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/constants/api_url.dart';
import 'package:ecommerce_app/core/network/dio_clint.dart';
import 'package:ecommerce_app/service_locator.dart';

abstract class CategorySource {
  Future<Either> getCategories();
}

class CategorySourceImpl extends CategorySource {
  @override
  Future<Either> getCategories() async {
    try {
      var response = await sl<DioClient>().get(ApiUrl.categires);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
