import 'package:ecommerce_app/domain/category/entity/category.dart';

abstract class GetCategoryState {}

class CategoryLoadingState extends GetCategoryState {}

class CategoryLoadedState extends GetCategoryState {
  final List<CategoryEntity> categories;

  CategoryLoadedState({required this.categories});
}

class CategoryErrorState extends GetCategoryState {
  final String error;

  CategoryErrorState({required this.error});
}
