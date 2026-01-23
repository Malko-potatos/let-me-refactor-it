import '../entities/inventory_item.dart';

abstract class InventoryRepository {
  Future<List<InventoryItem>> fetchAll();
  Future<InventoryItem> updateItem(String id, Map<String, dynamic> updates);
  Future<void> deleteItem(String id);
}
