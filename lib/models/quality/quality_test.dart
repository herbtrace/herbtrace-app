import 'test_results.dart';

class QualityTest {
  final String testId;
  final int batchId;
  final String labId;
  final DateTime dateOfTest;
  final List<TestResults> testResults;
  final String certificationReportUrl;
  final String? notes;

  QualityTest({
    required this.testId,
    required this.batchId,
    required this.labId,
    required this.dateOfTest,
    required this.testResults,
    required this.certificationReportUrl,
    this.notes,
  });

  factory QualityTest.fromJson(Map<String, dynamic> json) {
    return QualityTest(
      testId: json['test_id'] as String,
      batchId: json['batch_id'] as int,
      labId: json['lab_id'] as String,
      dateOfTest: DateTime.parse(json['date_of_test']),
      testResults: (json['test_results'] as List)
          .map((result) => TestResults.fromJson(result))
          .toList(),
      certificationReportUrl: json['certification_report_url'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'test_id': testId,
    'batch_id': batchId,
    'lab_id': labId,
    'date_of_test': dateOfTest.toIso8601String(),
    'test_results': testResults.map((result) => result.toJson()).toList(),
    'certification_report_url': certificationReportUrl,
    'notes': notes,
  };
}
