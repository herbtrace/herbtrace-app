import 'package:herbtrace_app/config/constants/api_endpoints.dart';
import 'package:herbtrace_app/services/network/api_service.dart';

class LoginService {
  final _apiService = ApiService();

  Future<Map<String, dynamic>> loginUser(String profileId) async {
    try {
      print(profileId);
      final response = await _apiService.get(
        ApiEndpoints.userLogin,
        queryParameters: {'profile_id': profileId},
      );

      final data = response.data;
      if (data == null || data is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      if (!data.containsKey('role') || !data.containsKey('data')) {
        throw Exception('Invalid login response format');
      }

      return data;
    } catch (e) {
      if (e.toString().contains('400')) {
        throw Exception('Invalid login credentials');
      }
      rethrow;
    }
  }
}
