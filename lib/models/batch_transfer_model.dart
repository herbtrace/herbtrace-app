class BatchTransfer {
  final String batchId;
  final String cropId;
  final DateTime startTime;
  final String profileId;

  BatchTransfer({
    required this.batchId,
    required this.cropId,
    required this.startTime,
    required this.profileId,
  });

  factory BatchTransfer.fromJson(Map<String, dynamic> json) {
    return BatchTransfer(
      batchId: json['batch_id'] as String,
      cropId: json['crop_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      profileId: json['profile_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batch_id': batchId,
      'crop_id': cropId,
      'start_time': startTime.toIso8601String(),
      'profile_id': profileId,
    };
  }
}
