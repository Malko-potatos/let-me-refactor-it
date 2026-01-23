import 'package:equatable/equatable.dart';

/// Domain model representing an inventory item
class InventoryItem extends Equatable {
  final int id;
  final String title;
  final String sku;
  final int quantity;

  const InventoryItem({
    required this.id,
    required this.title,
    required this.sku,
    required this.quantity,
  });

  /// Creates a copy of this item with the given fields replaced
  InventoryItem copyWith({int? id, String? title, String? sku, int? quantity}) {
    return InventoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      sku: sku ?? this.sku,
      quantity: quantity ?? this.quantity,
    );
  }

  /// Creates an InventoryItem from JSON
  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    final index = json['id'] as int;
    return InventoryItem(
      id: index,
      title: json['title'] as String? ?? '',
      sku: 'STOCK-${1000 + index}',
      quantity: (index * 13) % 100, // Simulated quantity 0-99
    );
  }

  /// Converts this item to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'sku': sku, 'quantity': quantity};
  }

  /// Returns truncated title for display
  String get displayTitle {
    if (title.length <= 20) return title;
    return '${title.substring(0, 20)}...';
  }

  @override
  List<Object?> get props => [id, title, sku, quantity];
}
