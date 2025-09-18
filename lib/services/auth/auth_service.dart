import 'package:herbtrace_app/services/network/api_service.dart';

class AuthService {
  final _apiService = ApiService();
  Future<bool> checkIfProfileExists(String profileId) async {
    try {
      final response = await _apiService.get(
        '/check_if_profile_exists',
        queryParameters: {'profile_id': profileId},
      );
      return response.data['exists'] as bool;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> loginUser(String profileId) async {
    try {
      final response = await _apiService.get(
        '/user_login',
        queryParameters: {'profile_id': profileId},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
