import 'package:hive/hive.dart';

abstract class BaseRepository<T> {
  final String boxName;

  BaseRepository(this.boxName);

  Box<T> get box => Hive.box<T>(boxName);

  Future<Box<T>> openBox() async {
    if (Hive.isBoxOpen(boxName)) return box;
    return Hive.openBox<T>(boxName);
  }

  Future<List<T>> getAll() async {
    final b = await openBox();
    return b.values.toList();
  }

  Future<T?> getById(String id) async {
    final b = await openBox();
    return b.get(id);
  }

  Future<void> save(String id, T item) async {
    final b = await openBox();
    await b.put(id, item);
  }

  Future<void> delete(String id) async {
    final b = await openBox();
    await b.delete(id);
  }

  Future<void> saveAll(Map<String, T> items) async {
    final b = await openBox();
    await b.putAll(items);
  }

  Future<void> clear() async {
    final b = await openBox();
    await b.clear();
  }
}
