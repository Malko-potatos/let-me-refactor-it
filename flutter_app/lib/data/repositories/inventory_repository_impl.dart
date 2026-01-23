import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  @override
  Future<List<InventoryItem>> fetchAll() async {
    // Mock delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const InventoryItem(
        id: '1',
        name: 'Drill',
        description: 'Power Drill',
        sku: 'DR-001',
        stockQuantity: 10,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '2',
        name: 'Hammer',
        description: 'Claw Hammer',
        sku: 'HM-002',
        stockQuantity: 25,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '3',
        name: 'Saw',
        description: 'Circular Saw',
        sku: 'SW-003',
        stockQuantity: 5,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '4',
        name: 'Wrench',
        description: 'Adjustable Wrench',
        sku: 'WR-004',
        stockQuantity: 15,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '5',
        name: 'Screwdriver',
        description: 'Phillips Head',
        sku: 'SD-005',
        stockQuantity: 50,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '6',
        name: 'Tape Measure',
        description: '25ft Tape Measure',
        sku: 'TM-006',
        stockQuantity: 30,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '7',
        name: 'Level',
        description: '24-inch Level',
        sku: 'LV-007',
        stockQuantity: 12,
        ownerId: 'system',
      ),
      const InventoryItem(
        id: '8',
        name: 'Pliers',
        description: 'Needle Nose Pliers',
        sku: 'PL-008',
        stockQuantity: 20,
        ownerId: 'system',
      ),
    ];
  }

  @override
  Future<InventoryItem> updateItem(
    String id,
    Map<String, dynamic> updates,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, we would fetch the existing item, merge updates, save, and return.
    // Here we mock the result.
    return InventoryItem(
      id: id,
      name: updates['name'] as String? ?? 'Updated Item',
      description: updates['description'] as String?,
      sku: updates['sku'] as String? ?? 'UPD-000',
      stockQuantity: updates['stockQuantity'] as int? ?? 0,
      ownerId: 'system',
    );
  }

  @override
  Future<void> deleteItem(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
