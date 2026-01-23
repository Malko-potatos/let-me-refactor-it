import '../entities/inventory_item.dart';

/// Abstract repository for inventory data operations
abstract class InventoryRepository {
  /// Fetches all inventory items from the remote server
  Future<List<InventoryItem>> fetchInventory();

  /// Updates an existing inventory item
  Future<InventoryItem> updateItem(InventoryItem item);

  /// Deletes an inventory item by ID
  Future<void> deleteItem(int id);

  /// Adds a new inventory item
  Future<InventoryItem> addItem(InventoryItem item);

  /// Searches inventory items by query
  Future<List<InventoryItem>> searchItems(String query);
}
