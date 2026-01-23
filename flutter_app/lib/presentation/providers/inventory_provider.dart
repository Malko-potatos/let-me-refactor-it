import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../../domain/usecases/inventory_usecases.dart';
import '../../data/repositories/inventory_repository_impl.dart';

/// Provider for HTTP client
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

/// Provider for InventoryRepository
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepositoryImpl(
    client: ref.watch(httpClientProvider),
  );
});

/// Provider for inventory use cases
final fetchInventoryUseCaseProvider = Provider<FetchInventoryUseCase>((ref) {
  return FetchInventoryUseCase(ref.watch(inventoryRepositoryProvider));
});

final updateItemUseCaseProvider = Provider<UpdateItemUseCase>((ref) {
  return UpdateItemUseCase(ref.watch(inventoryRepositoryProvider));
});

final deleteItemUseCaseProvider = Provider<DeleteItemUseCase>((ref) {
  return DeleteItemUseCase(ref.watch(inventoryRepositoryProvider));
});

final searchItemsUseCaseProvider = Provider<SearchItemsUseCase>((ref) {
  return SearchItemsUseCase(ref.watch(inventoryRepositoryProvider));
});

final addItemUseCaseProvider = Provider<AddItemUseCase>((ref) {
  return AddItemUseCase(ref.watch(inventoryRepositoryProvider));
});

/// State for inventory
class InventoryState {
  final List<InventoryItem> items;
  final List<InventoryItem> filteredItems;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  InventoryState({
    required this.items,
    required this.filteredItems,
    required this.isLoading,
    this.errorMessage,
    this.searchQuery = '',
  });

  InventoryState copyWith({
    List<InventoryItem>? items,
    List<InventoryItem>? filteredItems,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return InventoryState(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

/// Notifier for inventory state
class InventoryNotifier extends StateNotifier<InventoryState> {
  final FetchInventoryUseCase _fetchInventoryUseCase;
  final UpdateItemUseCase _updateItemUseCase;
  final DeleteItemUseCase _deleteItemUseCase;
  final SearchItemsUseCase _searchItemsUseCase;
  final AddItemUseCase _addItemUseCase;

  InventoryNotifier({
    required FetchInventoryUseCase fetchInventoryUseCase,
    required UpdateItemUseCase updateItemUseCase,
    required DeleteItemUseCase deleteItemUseCase,
    required SearchItemsUseCase searchItemsUseCase,
    required AddItemUseCase addItemUseCase,
  })  : _fetchInventoryUseCase = fetchInventoryUseCase,
        _updateItemUseCase = updateItemUseCase,
        _deleteItemUseCase = deleteItemUseCase,
        _searchItemsUseCase = searchItemsUseCase,
        _addItemUseCase = addItemUseCase,
        super(InventoryState(
          items: [],
          filteredItems: [],
          isLoading: false,
        ));

  /// Fetch all inventory items
  Future<void> fetchInventory() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await _fetchInventoryUseCase();
      state = state.copyWith(
        items: items,
        filteredItems: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load inventory: ${e.toString()}',
      );
    }
  }

  /// Update an inventory item
  Future<void> updateItem(InventoryItem item) async {
    try {
      final updatedItem = await _updateItemUseCase(item);
      final updatedItems = state.items.map((i) {
        return i.id == updatedItem.id ? updatedItem : i;
      }).toList();

      state = state.copyWith(
        items: updatedItems,
        filteredItems: _applySearch(updatedItems, state.searchQuery),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to update item: ${e.toString()}',
      );
    }
  }

  /// Delete an inventory item
  Future<void> deleteItem(int id) async {
    try {
      await _deleteItemUseCase(id);
      final updatedItems = state.items.where((item) => item.id != id).toList();
      state = state.copyWith(
        items: updatedItems,
        filteredItems: _applySearch(updatedItems, state.searchQuery),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to delete item: ${e.toString()}',
      );
    }
  }

  /// Search inventory items
  Future<void> searchItems(String query) async {
    state = state.copyWith(searchQuery: query);

    if (query.isEmpty) {
      state = state.copyWith(filteredItems: state.items);
      return;
    }

    // Client-side search for instant feedback
    state = state.copyWith(
      filteredItems: _applySearch(state.items, query),
    );

    // Optional: Server-side search for more complex queries
    try {
      final results = await _searchItemsUseCase(query);
      state = state.copyWith(filteredItems: results);
    } catch (e) {
      // Fall back to client-side results if server search fails
      // Ignore error
    }
  }

  /// Add a new inventory item
  Future<void> addItem(InventoryItem item) async {
    try {
      final newItem = await _addItemUseCase(item);
      final updatedItems = [...state.items, newItem];
      state = state.copyWith(
        items: updatedItems,
        filteredItems: _applySearch(updatedItems, state.searchQuery),
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to add item: ${e.toString()}',
      );
    }
  }

  /// Apply search filter to items
  List<InventoryItem> _applySearch(List<InventoryItem> items, String query) {
    if (query.isEmpty) return items;

    final lowerQuery = query.toLowerCase();
    return items.where((item) {
      return item.title.toLowerCase().contains(lowerQuery) ||
          item.sku.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider for InventoryNotifier
final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  return InventoryNotifier(
    fetchInventoryUseCase: ref.watch(fetchInventoryUseCaseProvider),
    updateItemUseCase: ref.watch(updateItemUseCaseProvider),
    deleteItemUseCase: ref.watch(deleteItemUseCaseProvider),
    searchItemsUseCase: ref.watch(searchItemsUseCaseProvider),
    addItemUseCase: ref.watch(addItemUseCaseProvider),
  );
});
