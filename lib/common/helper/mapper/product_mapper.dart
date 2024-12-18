import '../../../data/product/models/product.dart';
import '../../../domain/product/entities/product.dart';

class ProductMapper {
  static ProductEntity toEntity(ProductModel product) {
    return ProductEntity(
      id: product.id,
      bridge: product.bridge,
      color: product.color,
      colorName: product.colorName,
      createdAt: product.createdAt,
      description: product.description,
      features: product.features,
      frameWidth: product.frameWidth,
      images: product.images,
      lensHeight: product.lensHeight,
      lensWidth: product.lensWidth,
      material: product.material,
      name: product.name,
      price: product.price,
      rating: product.rating,
      reviews: product.reviews,
      rim: product.rim,
      shape: product.shape,
      size: product.size,
      sold: product.sold,
      stock: product.stock,
      templeLength: product.templeLength,
      weight: product.weight,
    );
  }
}
