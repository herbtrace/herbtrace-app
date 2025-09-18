import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class TransportProfile extends BaseProfile {
  final String? companyName;
  final List<String> certificates;

  const TransportProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    this.companyName,
    this.certificates = const [],
  }) : super(type: ProfileType.transport);

  @override
  List<String> get availableActions => [
    'Start Transport',
    'View Active Transports',
    'View History',
  ];

  @override
  String get profileTitle => 'Transport Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'companyName': companyName,
    'certificates': certificates,
  };

  factory TransportProfile.fromJson(Map<String, dynamic> json) =>
      TransportProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        companyName: json['companyName'] as String?,
        certificates: List<String>.from(json['certificates'] as List),
      );
}
