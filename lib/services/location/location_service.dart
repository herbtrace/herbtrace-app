import 'package:geolocator/geolocator.dart';
import 'package:herbtrace_app/models/common/lat_long.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;

  LocationService._internal();

  Future<bool> checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever;
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LatLong> getCurrentLocation() async {
    if (!await checkPermissions()) {
      throw Exception('Location permissions not granted');
    }

    if (!await isLocationServiceEnabled()) {
      throw Exception('Location services are disabled');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLong(latitude: position.latitude, longitude: position.longitude);
  }
}
