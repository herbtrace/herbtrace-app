import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class ManufacturerProfile extends BaseProfile {
  final String address;
  final String? licenseNo;
  final bool gmpCertified;
  final String companyEmail;

  const ManufacturerProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    required this.address,
    required this.companyEmail,
    this.licenseNo,
    this.gmpCertified = false,
  }) : super(type: ProfileType.manufacturer);

  @override
  List<String> get availableActions => [
    'Start Manufacturing',
    'View Active Manufacturing',
    'View History',
  ];

  @override
  String get profileTitle => 'Manufacturer Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'address': address,
    'licenseNo': licenseNo,
    'gmpCertified': gmpCertified,
    'companyEmail': companyEmail,
  };

  factory ManufacturerProfile.fromJson(Map<String, dynamic> json) =>
      ManufacturerProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        address: json['address'] as String,
        licenseNo: json['licenseNo'] as String?,
        gmpCertified: json['gmpCertified'] as bool,
        companyEmail: json['companyEmail'] as String,
      );
}
