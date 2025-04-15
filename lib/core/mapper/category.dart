import 'package:ecommerce_app/data/category/model/category_model.dart';
import 'package:ecommerce_app/domain/category/entity/category.dart';

class CategoryMapper {
  static CategoryEntity toEntity(CategoryModel categories) {
    return CategoryEntity(
      slug: categories.slug,
      name: categories.name,
      url: categories.url,
    );
  }
}
