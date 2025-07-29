class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final int discount;
  final int? categoryId;
  final int? subCategoryId;
  final String? pictureUrl;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.discount,
    this.categoryId,
    this.subCategoryId,
    this.pictureUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    description: json['description'] ?? '',
    price: (json['price'] as num).toDouble(),
    stock: json['stock'],
    discount: json['discount'],
    categoryId: json['category']?['id'],
    subCategoryId: json['subCategory']?['id'],
    pictureUrl: json['pictureUrl'],
  );
}
