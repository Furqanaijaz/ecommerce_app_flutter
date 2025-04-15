import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/common/usecase/usecase.dart';
import 'package:ecommerce_app/domain/product/repository/product.dart';
import 'package:ecommerce_app/service_locator.dart';

class GetProductByCategoryUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ProductRepository>().getProductsbycategory(params!);
  }
}
