import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/batch_transfer_model.dart';
import '../config/api_config.dart'; // You'll need to create this with your API base URL

class BatchTransferService {
  final String baseUrl = ApiConfig.baseUrl;

  // Start a new batch transfer
  Future<bool> startBatchTransfer(BatchTransfer batchTransfer) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(batchTransfer.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to start batch transfer: $e');
    }
  }

  // Get batch transfers for a profile
  Future<List<BatchTransfer>> getBatchTransfers({
    required String profileId,
    required String role,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/get',
        ).replace(queryParameters: {'profile_id': profileId, 'role': role}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => BatchTransfer.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load batch transfers');
    } catch (e) {
      throw Exception('Failed to get batch transfers: $e');
    }
  }
}
