import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local_storage_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/inventory_repository_impl.dart';
import '../../data/services/device_service_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../../domain/services/device_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return AuthRepositoryImpl(storage);
});

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return InventoryRepositoryImpl();
});

final deviceServiceProvider = Provider<DeviceService>((ref) {
  return DeviceServiceImpl();
});
