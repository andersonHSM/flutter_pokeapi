import 'package:flutter/foundation.dart';
import 'package:flutter_pokeapi/src/repositories/local_storage_repository/src/io_repository.dart';
import 'package:hive/hive.dart';

class HiveRepository<T> implements IORepository<T> {
  final Box<T> _box;

  HiveRepository({@required Box<T> box})
      : assert(box != null),
        _box = box;

  Future<void> addItem(String key, T object) async {
    if (!isBoxOpened) {
      return null;
    }

    await _box.put(key, object);
  }

  Future<void> removeItem(String key) async {
    if (!isBoxOpened) {
      return null;
    }

    await _box.delete(key);
  }

  T getItem(String key) {
    if (!isBoxOpened) {
      return null;
    }

    return _box.get(key);
  }

  bool get isBoxOpened => _box.isOpen;
}
