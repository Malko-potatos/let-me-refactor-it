import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory_item.dart';
import 'repository_providers.dart';

class InventoryNotifier extends AsyncNotifier<List<InventoryItem>> {
  @override
  Future<List<InventoryItem>> build() async {
    return _fetch();
  }

  Future<List<InventoryItem>> _fetch() async {
    final repository = ref.read(inventoryRepositoryProvider);
    return await repository.fetchAll();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<void> delete(String id) async {
    final repository = ref.read(inventoryRepositoryProvider);
    await repository.deleteItem(id);
    ref.invalidateSelf();
  }
}

final inventoryProvider =
    AsyncNotifierProvider<InventoryNotifier, List<InventoryItem>>(
      InventoryNotifier.new,
    );

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

final filteredInventoryProvider = Provider<AsyncValue<List<InventoryItem>>>((
  ref,
) {
  final inventoryAsync = ref.watch(inventoryProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return inventoryAsync.whenData((items) {
    if (query.isEmpty) return items;
    return items.where((item) {
      // Assuming name and sku are non-nullable or have getters
      return item.name.toLowerCase().contains(query) ||
          item.sku.toLowerCase().contains(query);
    }).toList();
  });
});
