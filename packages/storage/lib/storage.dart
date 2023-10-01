library storage;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKit {
  static final storageProvider = Provider((_) => const StorageKit());

  final FlutterSecureStorage _storage;

  const StorageKit({
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  }) : _storage = storage;

  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }

  Future<void> write({required String key, required String? value}) {
    return _storage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  Future<bool> containsKey({required String key}) {
    return _storage.containsKey(key: key);
  }
}
