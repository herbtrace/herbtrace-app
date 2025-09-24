import 'dart:convert';
import 'package:herbtrace_app/config/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<bool> transferBatch({
    required String fromId,
    required String toId,
    required String batchId,
    required String fromRole,
    required String toRole,
    required dynamic event,
  }) async {
    try {
      final url = Uri.parse('${ApiEndpoints.baseUrl}/transactions');

      final requestBody = {
        'from_id': fromId,
        'to_id': toId,
        'batch_id': batchId,
        'from_role': fromRole,
        'to_role': toRole,
        'start_time': DateTime.now().toIso8601String(),
        'event': event.toJson(),
      };
      print(requestBody);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      throw Exception('Failed to transfer batch: ${response.body}');
    } catch (e) {
      throw Exception('Failed to transfer batch: $e');
    }
  }

  static Future<Map<String, dynamic>> getTransactionByBatchId(
    String batchId,
  ) async {
    try {
      final url = Uri.parse('${ApiEndpoints.baseUrl}/transactions/$batchId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception('Failed to get transaction: ${response.body}');
    } catch (e) {
      throw Exception('Failed to get transaction: $e');
    }
  }

  static Future<bool> transferBatchWithQRData({
    required Map<String, dynamic> qrData,
    required String toId,
    required String toRole,
  }) async {
    try {
      final url = Uri.parse('${ApiEndpoints.baseUrl}/transactions');

      final requestBody = {
        'from_id': qrData['from_id'],
        'from_role': qrData['from_role'],
        'batch_id': qrData['batch_id'],
        'to_id': toId,
        'to_role': toRole,
        'start_time': DateTime.now().toIso8601String(),
        'event': qrData['data'],
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      throw Exception('Failed to transfer batch 2: ${response.body}');
    } catch (e) {
      print(e);

      throw Exception('Failed to transfer batch 2: $e');
    }
  }

  static Future<bool> endTransaction({
    required String transactionId,
    required DateTime endTime,
    required double quantity,
  }) async {
    try {
      final url = Uri.parse(
        '${ApiEndpoints.baseUrl}/transactions/$transactionId/end',
      );

      final requestBody = {
        'end_time': endTime.toIso8601String(),
        'quantity': quantity,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception('Failed to end transaction: ${response.body}');
    } catch (e) {
      throw Exception('Failed to end transaction: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getActiveTransactions() async {
    try {
      final url = Uri.parse('${ApiEndpoints.baseUrl}/transactions/active');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }

      throw Exception('Failed to get active transactions: ${response.body}');
    } catch (e) {
      throw Exception('Failed to get active transactions: $e');
    }
  }
}
