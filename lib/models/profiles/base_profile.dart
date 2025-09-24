import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';

abstract class BaseProfile {
  final String id;
  final String name;
  final String phoneNumber;
  final LatLong location;
  final ProfileType type;

  const BaseProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.type,
  });

  static BaseProfile fromJson(Map<String, dynamic> data, ProfileType role) {
    final location = LatLong.fromJson(data['location'] as Map<String, dynamic>);

    // ignore: unused_local_variable
    final baseData = {
      'id': data['id'] as String,
      'name': data['name'] as String,
      'phoneNumber': data['phoneNumber'] as String,
      'location': location,
      'type': role,
    };

    switch (role) {
      case ProfileType.farmer:
      case ProfileType.wildCollector:
      case ProfileType.processor:
      case ProfileType.laboratory:
      case ProfileType.manufacturer:
      case ProfileType.packer:
      case ProfileType.transport:
      case ProfileType.storage:
        // TODO: Implement specific profile types
        throw UnimplementedError(
          'Profile type ${role.toShortString()} not implemented yet',
        );
    }
  }

  Map<String, dynamic> toJson();

  List<String> get availableActions;
  String get profileTitle;

  @override
  String toString() => 'BaseProfile(id: $id, name: $name, type: $type)';
}
