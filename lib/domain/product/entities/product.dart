import '../../../data/product/models/product.dart';

class ProductEntity {
  ProductEntity({
    required this.id,
    required this.bridge,
    required this.color,
    required this.colorName,
    required this.createdAt,
    required this.description,
    required this.features,
    required this.frameWidth,
    required this.images,
    required this.lensHeight,
    required this.lensWidth,
    required this.material,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.rim,
    required this.shape,
    required this.size,
    required this.sold,
    required this.stock,
    required this.templeLength,
    required this.weight,
  });

  final String? id;
  final int? bridge;
  final List<String> color;
  final List<String> colorName;
  final String? createdAt;
  final String? description;
  final List<String> features;
  final int? frameWidth;
  final List<String> images;
  final int? lensHeight;
  final int? lensWidth;
  final List<String> material;
  final String? name;
  final int? price;
  final double? rating;
  final List<Review> reviews;
  final String? rim;
  final String? shape;
  final String? size;
  final int? sold;
  final int? stock;
  final int? templeLength;
  final String? weight;
}
