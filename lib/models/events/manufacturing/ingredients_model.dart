class IngredientsModel {
  final String ingredientId;
  final String name;
  final double quantity;
  final String units;

  IngredientsModel({
    required this.ingredientId,
    required this.name,
    required this.quantity,
    required this.units,
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json) {
    return IngredientsModel(
      ingredientId: json['ingredient_id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'].toDouble(),
      units: json['units'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'ingredient_id': ingredientId,
    'name': name,
    'quantity': quantity,
    'units': units,
  };
}
