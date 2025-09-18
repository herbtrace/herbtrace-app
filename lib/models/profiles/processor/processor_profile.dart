import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class ProcessorProfile extends BaseProfile {
  final String companyName;
  final String? companyAuthority;
  final String? address;
  final String? licenseNo;
  final String? responsiblePerson;
  final List<String> certificationStatus;
  final List<String> facilities;
  final String companyEmail;

  const ProcessorProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    required this.companyName,
    required this.companyEmail,
    this.companyAuthority,
    this.address,
    this.licenseNo,
    this.responsiblePerson,
    this.certificationStatus = const [],
    this.facilities = const [],
  }) : super(type: ProfileType.processor);

  @override
  List<String> get availableActions => [
    'Start Processing',
    'View Active Processing',
    'View History',
  ];

  @override
  String get profileTitle => 'Processor Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'companyName': companyName,
    'companyAuthority': companyAuthority,
    'address': address,
    'licenseNo': licenseNo,
    'responsiblePerson': responsiblePerson,
    'certificationStatus': certificationStatus,
    'facilities': facilities,
    'companyEmail': companyEmail,
  };

  factory ProcessorProfile.fromJson(Map<String, dynamic> json) =>
      ProcessorProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        companyName: json['companyName'] as String,
        companyAuthority: json['companyAuthority'] as String?,
        address: json['address'] as String?,
        licenseNo: json['licenseNo'] as String?,
        responsiblePerson: json['responsiblePerson'] as String?,
        certificationStatus: List<String>.from(
          json['certificationStatus'] as List,
        ),
        facilities: List<String>.from(json['facilities'] as List),
        companyEmail: json['companyEmail'] as String,
      );
}
