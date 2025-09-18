import 'package:herbtrace_app/config/constants/api_endpoints.dart';
import 'package:herbtrace_app/services/network/api_service.dart';

class ProfileCheckService {
  final _apiService = ApiService();

  Future<bool> checkIfProfileExists(String profileId) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.checkProfileExists,
        queryParameters: {'profile_id': profileId},
      );

      final data = response.data as Map<String, dynamic>;
      return data['exists'] as bool;
    } catch (e) {
      if (e.toString().contains('422')) {
        throw Exception('Invalid profile ID format');
      }
      rethrow;
    }
  }
}
