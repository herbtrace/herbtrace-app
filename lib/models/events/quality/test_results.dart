class TestResults {
  final String testId;
  final String testType;
  final double value;
  final String units;
  final String? referenceRange;
  final bool passed;

  TestResults({
    required this.testId,
    required this.testType,
    required this.value,
    required this.units,
    this.referenceRange,
    required this.passed,
  });

  factory TestResults.fromJson(Map<String, dynamic> json) {
    return TestResults(
      testId: json['test_id'] as String,
      testType: json['test_type'] as String,
      value: json['value'].toDouble(),
      units: json['units'] as String,
      referenceRange: json['reference_range'] as String?,
      passed: json['passed'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'test_id': testId,
    'test_type': testType,
    'value': value,
    'units': units,
    if (referenceRange != null) 'reference_range': referenceRange,
    'passed': passed,
  };
}
