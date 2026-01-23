import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory_item.dart';
import '../widgets/glass_card.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../providers/inventory_provider.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  ConsumerState<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  late InventoryItem _item;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the item from navigation arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is InventoryItem) {
      _item = args;
    }
  }

  void _showEditBottomSheet() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditBottomSheet(
        item: _item,
        onItemUpdated: (updatedItem) {
          ref.read(inventoryProvider.notifier).updateItem(updatedItem);
          setState(() {
            _item = updatedItem;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _confirmDelete() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.background,
        title: const Text('Delete Item?'),
        content: const Text('Are you certain you want to delete this item?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.dialogBorderRadius),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              HapticFeedback.heavyImpact();
              await ref.read(inventoryProvider.notifier).deleteItem(_item.id);
              if (mounted) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailsCard(),
                  const SizedBox(height: AppConstants.spacingL),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          _item.displayTitle,
          style: const TextStyle(color: Colors.white),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return GlassCard(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Item Details',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: AppConstants.spacingM),
          _DetailRow(label: 'ID', value: _item.id.toString()),
          const SizedBox(height: AppConstants.spacingS),
          _DetailRow(label: 'SKU', value: _item.sku),
          const SizedBox(height: AppConstants.spacingS),
          _DetailRow(label: 'Quantity', value: _item.quantity.toString()),
          const SizedBox(height: AppConstants.spacingS),
          _DetailRow(label: 'Title', value: _item.title),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _showEditBottomSheet,
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingM),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _confirmDelete,
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _EditBottomSheet extends StatefulWidget {
  final InventoryItem item;
  final Function(InventoryItem) onItemUpdated;

  const _EditBottomSheet({
    required this.item,
    required this.onItemUpdated,
  });

  @override
  State<_EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<_EditBottomSheet> {
  late TextEditingController _titleController;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.title);
    _isValid = _titleController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    setState(() {
      _isValid = value.trim().isNotEmpty;
    });
  }

  void _saveChanges() {
    if (_isValid) {
      HapticFeedback.lightImpact();
      widget.onItemUpdated(widget.item.copyWith(title: _titleController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppConstants.bottomSheetBorderRadius),
        ),
        child: GlassCard(
          margin: const EdgeInsets.all(0),
          borderRadius: BorderRadius.circular(0),
          padding: const EdgeInsets.all(AppConstants.bottomSheetPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingL),
              Text(
                'Edit Item',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: AppConstants.spacingL),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                onChanged: _validateInput,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: AppConstants.spacingM),
              ElevatedButton(
                onPressed: _isValid ? _saveChanges : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
