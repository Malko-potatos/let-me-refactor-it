import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory_item.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_app_bar.dart';
import '../widgets/glass_states.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../providers/inventory_provider.dart';

class InventoryListScreen extends ConsumerStatefulWidget {
  const InventoryListScreen({super.key});

  @override
  ConsumerState<InventoryListScreen> createState() =>
      _InventoryListScreenState();
}

class _InventoryListScreenState extends ConsumerState<InventoryListScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimationController.forward();

    // Fetch inventory on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(inventoryProvider.notifier).fetchInventory();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    ref.read(inventoryProvider.notifier).searchItems(query);
  }

  void _handleScanBarcode() {
    HapticFeedback.mediumImpact();
    Navigator.of(context).pushNamed('/scanner');
  }

  void _handleItemTap(InventoryItem item) {
    HapticFeedback.lightImpact();
    Navigator.of(context).pushNamed(
      '/inventory/detail',
      arguments: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryProvider);
    final items = inventoryState.filteredItems;
    final isLoading = inventoryState.isLoading;
    final errorMessage = inventoryState.errorMessage;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const GlassAppBar(title: 'Inventory'),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildContent(items, isLoading, errorMessage),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimationController,
        child: FloatingActionButton(
          onPressed: _handleScanBarcode,
          backgroundColor: AppColors.secondary,
          elevation: 8,
          child: const Icon(Icons.qr_code_scanner, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      color: AppColors.primary,
      child: SearchBar(
        controller: _searchController,
        leading: const Icon(
          Icons.search,
          color: AppColors.primary,
        ),
        trailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _handleSearch('');
            },
          ),
        ],
        onChanged: _handleSearch,
        hintText: 'Search items...',
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
      ),
    );
  }

  Widget _buildContent(
      List<InventoryItem> items, bool isLoading, String? errorMessage) {
    if (isLoading) {
      return const GlassLoadingIndicator(message: 'Loading inventory...');
    }

    if (errorMessage != null) {
      return GlassErrorMessage(
        message: errorMessage,
        onRetry: () {
          ref.read(inventoryProvider.notifier).fetchInventory();
        },
      );
    }

    if (items.isEmpty) {
      return const GlassEmptyState(
        message: 'No items found',
        icon: Icons.inventory_2_outlined,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.lightImpact();
        await ref.read(inventoryProvider.notifier).fetchInventory();
      },
      displacement: AppConstants.spacingL,
      color: AppColors.primary,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(AppConstants.spacingM),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppConstants.gridCrossAxisCount,
                childAspectRatio: AppConstants.gridChildAspectRatio,
                crossAxisSpacing: AppConstants.gridSpacing,
                mainAxisSpacing: AppConstants.gridSpacing,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildItemCard(items[index], index);
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(InventoryItem item, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: _ItemCard(
        item: item,
        onTap: () => _handleItemTap(item),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onTap;

  const _ItemCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkuBadge(context),
              const SizedBox(height: AppConstants.spacingS),
              Text(
                item.displayTitle,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.inventory,
                    size: AppConstants.iconSizeS,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.quantity.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkuBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingS,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.success,
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Text(
        item.sku,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: AppConstants.fontSizeXS,
              color: AppColors.primary,
            ),
      ),
    );
  }
}
