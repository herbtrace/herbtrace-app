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

  Map<String, dynamic> toJson();

  List<String> get availableActions;
  String get profileTitle;

  @override
  String toString() => 'BaseProfile(id: $id, name: $name, type: $type)';
}
