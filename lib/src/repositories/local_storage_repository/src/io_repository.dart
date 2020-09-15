abstract class IORepository<T> {
  Future<void> addItem(String key, T object) async {}

  Future<void> removeItem(String key) async {}

  // ignore: missing_return
  T getItem(String key) {}

  bool get isBoxOpened;
}
