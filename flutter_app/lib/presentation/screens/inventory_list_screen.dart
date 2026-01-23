import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../providers/inventory_provider.dart';
import '../providers/device_provider.dart';
import '../widgets/item_card.dart';

class InventoryListScreen extends ConsumerWidget {
  const InventoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryState = ref.watch(filteredInventoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventory',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.secondary.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppColors.background,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search items...',
                prefixIcon: Icon(Icons.search, color: AppColors.secondary),
                filled: true,
                fillColor: AppColors.surface,
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).setQuery(value);
              },
            ),
          ),
          Expanded(
            child: inventoryState.when(
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'No items found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ItemCard(
                      item: item,
                      onTap: () {
                        context.go('/inventory/${item.id}');
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(deviceProvider.notifier).scanBarcode();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Simulating Scan Barcode... Check logs or device state',
              ),
            ),
          );
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }
}
