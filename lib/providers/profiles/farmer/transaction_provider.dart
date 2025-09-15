import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/models/common/collection_event.dart';

class TransactionState {
  final List<CollectionEvent> activeTransactions;
  final List<CollectionEvent> completedTransactions;
  final bool isLoading;
  final String? error;

  const TransactionState({
    this.activeTransactions = const [],
    this.completedTransactions = const [],
    this.isLoading = false,
    this.error,
  });

  TransactionState copyWith({
    List<CollectionEvent>? activeTransactions,
    List<CollectionEvent>? completedTransactions,
    bool? isLoading,
    String? error,
  }) {
    return TransactionState(
      activeTransactions: activeTransactions ?? this.activeTransactions,
      completedTransactions:
          completedTransactions ?? this.completedTransactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class TransactionNotifier extends StateNotifier<TransactionState> {
  TransactionNotifier() : super(const TransactionState());

  Future<void> startTransaction(String cropId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: Implement API call to start transaction
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to start transaction: $e',
      );
    }
  }

  Future<void> endTransaction(String transactionId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: Implement API call to end transaction
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to end transaction: $e',
      );
    }
  }

  Future<void> loadTransactions() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // TODO: Implement API call to load transactions
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load transactions: $e',
      );
    }
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>(
      (ref) => TransactionNotifier(),
    );
