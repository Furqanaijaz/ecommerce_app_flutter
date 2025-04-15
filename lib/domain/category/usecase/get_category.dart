import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/common/usecase/usecase.dart';
import 'package:ecommerce_app/domain/category/repository/category.dart';
import 'package:ecommerce_app/service_locator.dart';

class GetCategoryUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<CategoryRepository>().getCategories();
  }
}
