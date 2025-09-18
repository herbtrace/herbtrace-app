import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class LaboratoryProfile extends BaseProfile {
  final String companyName;
  final String? accreditationNo;
  final List<String> testCapabilities;
  final String companyEmail;
  final List<String> ayushCertificates;

  const LaboratoryProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    required this.companyName,
    required this.companyEmail,
    this.accreditationNo,
    this.testCapabilities = const [],
    this.ayushCertificates = const [],
  }) : super(type: ProfileType.laboratory);

  @override
  List<String> get availableActions => [
    'Start Testing',
    'View Active Tests',
    'View History',
  ];

  @override
  String get profileTitle => 'Laboratory Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'companyName': companyName,
    'accreditationNo': accreditationNo,
    'testCapabilities': testCapabilities,
    'companyEmail': companyEmail,
    'ayushCertificates': ayushCertificates,
  };

  factory LaboratoryProfile.fromJson(Map<String, dynamic> json) =>
      LaboratoryProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        companyName: json['companyName'] as String,
        accreditationNo: json['accreditationNo'] as String?,
        testCapabilities: List<String>.from(json['testCapabilities'] as List),
        companyEmail: json['companyEmail'] as String,
        ayushCertificates: List<String>.from(json['ayushCertificates'] as List),
      );
}
