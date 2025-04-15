import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/common/usecase/usecase.dart';
import 'package:ecommerce_app/domain/product/repository/product.dart';
import 'package:ecommerce_app/service_locator.dart';

class GetAllProductsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<ProductRepository>().getAllProducts();
  }
}
