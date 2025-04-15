import 'package:ecommerce_app/data/product/model/products_model.dart';
import 'package:ecommerce_app/domain/product/entity/product.dart';

class ProductMapper {
  static ProductEntity mapModelToEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      price: model.price,
      discountPercentage: model.discountPercentage,
      rating: model.rating,
      stock: model.stock,
      tags: model.tags,
      brand: model.brand,
      sku: model.sku,
      weight: model.weight,
      dimensions:
          "${model.dimensions.width}x${model.dimensions.height}x${model.dimensions.depth}", // String representation
      availabilityStatus: model.availabilityStatus,
      reviews: model.reviews.map(mapReviewToEntity).toList(),
      thumbnail: model.thumbnail,
      images: model.images,
    );
  }

  static ReviewEntity mapReviewToEntity(Review review) {
    return ReviewEntity(
      rating: review.rating,
      comment: review.comment,
      reviewerName: review.reviewerName,
    );
  }
}
