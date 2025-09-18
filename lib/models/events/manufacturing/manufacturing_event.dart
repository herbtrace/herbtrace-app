import 'ingredients_model.dart';

class ManufacturingEvent {
  final String manufacturingId;
  final String productName;
  final String batchIdsUsed;
  final String profileId;
  final DateTime manufactureDate;
  final List<IngredientsModel> ingredients;
  final bool gmpCompliance;
  final List<String>? testIds;
  final double finalQuantity;
  final String? notes;

  ManufacturingEvent({
    required this.manufacturingId,
    required this.productName,
    required this.batchIdsUsed,
    required this.profileId,
    required this.manufactureDate,
    required this.ingredients,
    this.gmpCompliance = true,
    this.testIds,
    required this.finalQuantity,
    this.notes,
  });

  factory ManufacturingEvent.fromJson(Map<String, dynamic> json) {
    return ManufacturingEvent(
      manufacturingId: json['manufacturing_id'] as String,
      productName: json['product_name'] as String,
      batchIdsUsed: json['batch_ids_used'] as String,
      profileId: json['profile_id'] as String,
      manufactureDate: DateTime.parse(json['manufacture_date']),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => IngredientsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      gmpCompliance: json['gmp_compliance'] as bool? ?? true,
      testIds: json['test_ids'] != null
          ? List<String>.from(json['test_ids'])
          : null,
      finalQuantity: json['final_quantity'].toDouble(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'manufacturing_id': manufacturingId,
    'product_name': productName,
    'batch_ids_used': batchIdsUsed,
    'profile_id': profileId,
    'manufacture_date': manufactureDate.toIso8601String(),
    'ingredients': ingredients.map((e) => e.toJson()).toList(),
    'gmp_compliance': gmpCompliance,
    if (testIds != null) 'test_ids': testIds,
    'final_quantity': finalQuantity,
    if (notes != null) 'notes': notes,
  };
}
