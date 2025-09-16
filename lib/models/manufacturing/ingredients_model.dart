class IngredientsModel {
  final String name;
  final int batchId;
  final double quantity;
  final String units;

  IngredientsModel({
    required this.name,
    required this.batchId,
    required this.quantity,
    required this.units,
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json) {
    return IngredientsModel(
      name: json['name'] as String,
      batchId: json['batch_id'] as int,
      quantity: json['quantity'] as double,
      units: json['units'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'batch_id': batchId,
    'quantity': quantity,
    'units': units,
  };
}
