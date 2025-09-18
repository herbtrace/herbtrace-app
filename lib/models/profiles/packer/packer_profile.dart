import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class PackerProfile extends BaseProfile {
  final String licenseNo;
  final String companyEmail;

  const PackerProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    required this.licenseNo,
    required this.companyEmail,
  }) : super(type: ProfileType.packer);

  @override
  List<String> get availableActions => [
    'Start Packing',
    'View Active Packing',
    'View History',
  ];

  @override
  String get profileTitle => 'Packer Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'licenseNo': licenseNo,
    'companyEmail': companyEmail,
  };

  factory PackerProfile.fromJson(Map<String, dynamic> json) => PackerProfile(
    id: json['id'] as String,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
    licenseNo: json['licenseNo'] as String,
    companyEmail: json['companyEmail'] as String,
  );
}
