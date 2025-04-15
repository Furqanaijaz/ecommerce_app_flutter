import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/mapper/category.dart';
import 'package:ecommerce_app/data/category/model/category_model.dart';
import 'package:ecommerce_app/data/category/source/category.dart';
import 'package:ecommerce_app/domain/category/repository/category.dart';
import 'package:ecommerce_app/service_locator.dart';

class CategoryRepoImpl extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var returnData = await sl<CategorySource>().getCategories();
    return returnData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var categories =
            List.from(data)
                .map(
                  (item) =>
                      CategoryMapper.toEntity(CategoryModel.fromJson(item)),
                )
                .toList();
        return Right(categories);
      },
    );
  }
}
