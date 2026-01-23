import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../providers/inventory_provider.dart';
import '../providers/device_provider.dart';

class ItemDetailScreen extends ConsumerWidget {
  final String id;

  const ItemDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryState = ref.watch(inventoryProvider);

    // Find the item from the list
    final itemAsync = inventoryState.whenData((items) {
      try {
        return items.firstWhere((element) => element.id == id);
      } catch (_) {
        return null;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Item Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.secondary.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: itemAsync.when(
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Item not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(label: 'Name', value: item.name),
                const SizedBox(height: AppSpacing.md),
                _DetailRow(label: 'SKU', value: item.sku),
                const SizedBox(height: AppSpacing.md),
                _DetailRow(
                  label: 'Description',
                  value: item.description ?? 'No description available',
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref.read(deviceProvider.notifier).captureImage();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Simulating Camera Capture...'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('TAKE PHOTO'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.secondary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await ref
                              .read(inventoryProvider.notifier)
                              .delete(item.id);
                          if (context.mounted) {
                            context.pop();
                          }
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('DELETE'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
