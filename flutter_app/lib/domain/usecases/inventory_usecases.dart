import '../entities/inventory_item.dart';
import '../repositories/inventory_repository.dart';

/// Use case for fetching all inventory items
class FetchInventoryUseCase {
  final InventoryRepository repository;

  FetchInventoryUseCase(this.repository);

  Future<List<InventoryItem>> call() async {
    return await repository.fetchInventory();
  }
}

/// Use case for updating an inventory item
class UpdateItemUseCase {
  final InventoryRepository repository;

  UpdateItemUseCase(this.repository);

  Future<InventoryItem> call(InventoryItem item) async {
    return await repository.updateItem(item);
  }
}

/// Use case for deleting an inventory item
class DeleteItemUseCase {
  final InventoryRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteItem(id);
  }
}

/// Use case for searching inventory items
class SearchItemsUseCase {
  final InventoryRepository repository;

  SearchItemsUseCase(this.repository);

  Future<List<InventoryItem>> call(String query) async {
    return await repository.searchItems(query);
  }
}

/// Use case for adding a new inventory item
class AddItemUseCase {
  final InventoryRepository repository;

  AddItemUseCase(this.repository);

  Future<InventoryItem> call(InventoryItem item) async {
    return await repository.addItem(item);
  }
}
