class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final List<String> images;
  final String dimensions; // Simplified for entity
  final String availabilityStatus;
  final List<ReviewEntity> reviews;
  final String thumbnail;
  final int quantity; // ✅ NEW

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.images,
    required this.dimensions,
    required this.availabilityStatus,
    required this.reviews,
    required this.thumbnail,
    this.quantity = 1,
  });
  ProductEntity copyWith({int? quantity}) {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      images: images,
      dimensions: dimensions,
      availabilityStatus: availabilityStatus,
      reviews: reviews,
      thumbnail: thumbnail,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ProductEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

class ReviewEntity {
  final int rating;
  final String comment;
  final String reviewerName;

  ReviewEntity({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });
}
