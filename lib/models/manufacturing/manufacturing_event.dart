import 'ingredients_model.dart';

class ManufacturingEvent {
  final String manufacturingId;
  final String productName;
  final List<int> batchIdsUsed;
  final String manufacturerId;
  final DateTime manufactureDate;
  final List<IngredientsModel> ingredients;
  final bool gmpCompliance;
  final List<String> testIds;
  final double finalQuantity;
  final String? notes;

  ManufacturingEvent({
    required this.manufacturingId,
    required this.productName,
    required this.batchIdsUsed,
    required this.manufacturerId,
    required this.manufactureDate,
    required this.ingredients,
    required this.gmpCompliance,
    required this.testIds,
    required this.finalQuantity,
    this.notes,
  });

  factory ManufacturingEvent.fromJson(Map<String, dynamic> json) {
    return ManufacturingEvent(
      manufacturingId: json['manufacturing_id'] as String,
      productName: json['product_name'] as String,
      batchIdsUsed: List<int>.from(json['batch_ids_used']),
      manufacturerId: json['manufacturer_id'] as String,
      manufactureDate: DateTime.parse(json['manufacture_date']),
      ingredients: (json['ingredients'] as List)
          .map((ingredient) => IngredientsModel.fromJson(ingredient))
          .toList(),
      gmpCompliance: json['GMP_compliance'] as bool,
      testIds: List<String>.from(json['test_ids']),
      finalQuantity: json['final_quantity'] as double,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'manufacturing_id': manufacturingId,
    'product_name': productName,
    'batch_ids_used': batchIdsUsed,
    'manufacturer_id': manufacturerId,
    'manufacture_date': manufactureDate.toIso8601String(),
    'ingredients': ingredients
        .map((ingredient) => ingredient.toJson())
        .toList(),
    'GMP_compliance': gmpCompliance,
    'test_ids': testIds,
    'final_quantity': finalQuantity,
    'notes': notes,
  };
}
