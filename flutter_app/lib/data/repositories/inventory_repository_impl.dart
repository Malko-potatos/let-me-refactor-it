import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/inventory_item.dart';
import '../../domain/repositories/inventory_repository.dart';

/// Implementation of InventoryRepository using HTTP
class InventoryRepositoryImpl implements InventoryRepository {
  final http.Client client;
  final String baseUrl;

  InventoryRepositoryImpl({
    required this.client,
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
  });

  @override
  Future<List<InventoryItem>> fetchInventory() async {
    try {
      // Simulate data heavy load
      await Future.delayed(const Duration(seconds: 1));

      final response = await client.get(
        Uri.parse('$baseUrl/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => InventoryItem.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load inventory: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<InventoryItem> updateItem(InventoryItem item) async {
    try {
      // Simulate API update with delay
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, this would make a PUT/PATCH request
      // For now, we return the updated item
      return item;
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      // Simulate API delete with delay
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, this would make a DELETE request
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }

  @override
  Future<InventoryItem> addItem(InventoryItem item) async {
    try {
      // Simulate API add with delay
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, this would make a POST request
      // For now, return the item with a new ID
      return item.copyWith(id: DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }

  @override
  Future<List<InventoryItem>> searchItems(String query) async {
    // Client-side search - in a real app this would be a server-side search
    final allItems = await fetchInventory();

    if (query.isEmpty) return allItems;

    final lowerQuery = query.toLowerCase();
    return allItems
        .where((item) =>
            item.title.toLowerCase().contains(lowerQuery) ||
            item.sku.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
