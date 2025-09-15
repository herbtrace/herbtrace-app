import 'package:herbtrace_app/config/constants/api_endpoints.dart';
import 'package:herbtrace_app/models/common/collection_event.dart';
import 'package:herbtrace_app/services/network/api_service.dart';

class FarmerApi {
  final ApiService _apiService;

  FarmerApi(this._apiService);

  Future<List<CollectionEvent>> getTransactions() async {
    final response = await _apiService.get(ApiEndpoints.farmerTransactions);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => CollectionEvent.fromJson(json)).toList();
  }

  Future<CollectionEvent> startTransaction(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiEndpoints.startTransaction,
      data: data,
    );
    return CollectionEvent.fromJson(response.data['data']);
  }

  Future<CollectionEvent> endTransaction(String transactionId) async {
    final response = await _apiService.post(
      ApiEndpoints.endTransaction,
      data: {'transactionId': transactionId},
    );
    return CollectionEvent.fromJson(response.data['data']);
  }

  Future<bool> validateCrop(String cropId, Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiEndpoints.validateCrop,
      data: {'cropId': cropId, ...data},
    );
    return response.data['data']['isValid'] as bool;
  }
}
