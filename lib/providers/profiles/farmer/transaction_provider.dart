import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:herbtrace_app/models/crop_model.dart';
import 'package:herbtrace_app/config/api_config.dart';
import 'package:herbtrace_app/services/crop_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BatchCropModel {
  final String batchId;
  final String cropId;
  final DateTime startTime;

  BatchCropModel({
    required this.batchId,
    required this.cropId,
    required this.startTime,
  });

  factory BatchCropModel.fromJson(Map<String, dynamic> json) {
    return BatchCropModel(
      batchId: json['batch_id'] as String,
      cropId: json['crop_id'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
    );
  }
}

class TransactionState {
  final List<BatchCropModel> activeTransactions;
  final bool isLoading;
  final String? error;
  final Map<String, CropModel> crops;
  const TransactionState({
    this.activeTransactions = const [],
    this.isLoading = false,
    this.error,
    this.crops = const {},
  });

  TransactionState copyWith({
    List<BatchCropModel>? activeTransactions,
    bool? isLoading,
    String? error,
    Map<String, CropModel>? crops,
  }) {
    return TransactionState(
      activeTransactions: activeTransactions ?? this.activeTransactions,
      isLoading: isLoading ?? this.isLoading,
      crops: crops ?? this.crops,
      error: error,
    );
  }
}

class TransactionNotifier extends StateNotifier<TransactionState> {
  final _cropService = CropService();

  TransactionNotifier() : super(const TransactionState());

  Future<void> loadTransactions(String profileId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/get',
        ).replace(queryParameters: {'profile_id': profileId, 'role': 'farmer'}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load transactions');
      }

      final List<dynamic> data = jsonDecode(response.body);
      final transactions = data
          .map((json) => BatchCropModel.fromJson(json))
          .toList();

      final Map<String, CropModel> crops = {};
      for (var transaction in transactions) {
        if (!crops.containsKey(transaction.cropId)) {
          final crop = await _cropService.getCropById(transaction.cropId);
          if (crop != null) {
            crops[transaction.cropId] = crop;
          }
        }
      }

      state = state.copyWith(
        activeTransactions: transactions,
        crops: crops,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load transactions: $e',
      );
    }
  }

  Future<void> startTransaction(CropModel crop) async {
    state = state.copyWith(isLoading: true, error: null);
    // Get profileId from SharedPreferences or use "456" as default
    final prefs = await SharedPreferences.getInstance();
    final String profileId = prefs.getString('profileId') ?? "456";
    try {
      final batchId = DateTime.now().millisecondsSinceEpoch.toString();
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'batch_id': batchId,
          'crop_id': crop.cropId,
          'start_time': DateTime.now().toIso8601String(),
          'profile_id': profileId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to start transaction');
      }

      await loadTransactions(profileId);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to start transaction: $e',
      );
    }
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>(
      (ref) => TransactionNotifier(),
    );
