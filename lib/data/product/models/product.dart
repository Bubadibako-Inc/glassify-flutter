class ProductModel {
  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"],
      bridge: json["bridge"],
      color: json["color"] == null
          ? []
          : List<String>.from(json["color"]!.map((x) => x)),
      colorName: json["color_name"] == null
          ? []
          : List<String>.from(json["color_name"]!.map((x) => x)),
      createdAt: json["created_at"],
      description: json["description"],
      features: json["features"] == null
          ? []
          : List<String>.from(json["features"]!.map((x) => x)),
      frameWidth: json["frame_width"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      lensHeight: json["lens_height"],
      lensWidth: json["lens_width"],
      material: json["material"] == null
          ? []
          : List<String>.from(json["material"]!.map((x) => x)),
      name: json["name"],
      price: json["price"],
      rating: json["rating"],
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      rim: json["rim"],
      shape: json["shape"],
      size: json["size"],
      sold: json["sold"],
      stock: json["stock"],
      templeLength: json["temple_length"],
      weight: json["weight"],
    );
  }
}

class Review {
  final String? comment;
  final DateTime? date;
  final int? rating;
  final String? userId;
  final String? userName;
  final String? userAvatar;

  Review({
    required this.comment,
    required this.date,
    required this.rating,
    required this.userId,
    this.userName,
    this.userAvatar,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json["comment"],
      date: DateTime.tryParse(json["date"] ?? ""),
      rating: json["rating"],
      userId: json["user_id"],
      userName: json["user_name"], // Added userName
      userAvatar: json["user_avatar"], // Added userAvatar
    );
  }
}
