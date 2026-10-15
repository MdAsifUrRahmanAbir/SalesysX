class ProductModel {
  final String id;
  final String name;
  final String category;
  final double unitPrice;
  final bool active;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.unitPrice,
    this.active = true,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      category: map['category'] as String? ?? '',
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0,
      active: map['active'] as bool? ?? true,
    );
  }
}
