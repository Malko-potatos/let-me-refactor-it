// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    _InventoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      sku: json['sku'] as String,
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      ownerId: json['ownerId'] as String,
    );

Map<String, dynamic> _$InventoryItemToJson(_InventoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'sku': instance.sku,
      'stockQuantity': instance.stockQuantity,
      'ownerId': instance.ownerId,
    };
