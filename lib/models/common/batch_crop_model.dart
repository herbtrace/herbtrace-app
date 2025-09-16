class BatchCropModel {
  String batchId;
  String cropId;
  DateTime date;

  BatchCropModel({
    required this.batchId,
    required this.cropId,
    required this.date,
  });

  factory BatchCropModel.fromJson(Map<String, dynamic> json) {
    return BatchCropModel(
      batchId: json['batch_id'],
      cropId: json['crop_id'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batch_id': batchId,
      'crop_id': cropId,
      'date': date.toIso8601String(),
    };
  }
}
