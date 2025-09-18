import 'package:herbtrace_app/models/events/quality/test_results.dart';

class QualityTest {
  final String testId;
  final String batchId;
  final String labId;
  final DateTime dateOfTest;
  final List<TestResults> testResults;
  final String? certificationReportUrl;
  final String? notes;

  QualityTest({
    required this.testId,
    required this.batchId,
    required this.labId,
    required this.dateOfTest,
    required this.testResults,
    this.certificationReportUrl,
    this.notes,
  });

  factory QualityTest.fromJson(Map<String, dynamic> json) {
    return QualityTest(
      testId: json['test_id'] as String,
      batchId: json['batch_id'] as String,
      labId: json['lab_id'] as String,
      dateOfTest: DateTime.parse(json['date_of_test']),
      testResults: (json['test_results'] as List)
          .map((e) => TestResults.fromJson(e as Map<String, dynamic>))
          .toList(),
      certificationReportUrl: json['certification_report_url'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'test_id': testId,
    'batch_id': batchId,
    'lab_id': labId,
    'date_of_test': dateOfTest.toIso8601String(),
    'test_results': testResults.map((e) => e.toJson()).toList(),
    if (certificationReportUrl != null)
      'certification_report_url': certificationReportUrl,
    if (notes != null) 'notes': notes,
  };
}
