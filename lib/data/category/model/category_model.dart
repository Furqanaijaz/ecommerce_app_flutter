import 'package:ecommerce_app/domain/category/entity/category.dart';

class CategoryModel {
  final String slug;
  final String name;
  final String url;

  CategoryModel({required this.slug, required this.name, required this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json["slug"],
      name: json["name"],
      url: json["url"],
    );
  }
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      slug: map["slug"] as String,
      name: map["name"] as String,
      url: map["url"] as String,
    );
  }
}

extension CategoryXModel on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(slug: slug, name: name, url: url);
  }
}
