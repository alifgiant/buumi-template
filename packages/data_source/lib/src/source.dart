abstract class Source<T> {
  const Source();

  Future<T?> get(
    String id, {
    Map<String, dynamic> param = const {},
    String idKey = 'id',
  });

  Future<Iterable<T>> getAll({
    Map<String, dynamic> param = const {},
  });

  /// insert if data is a new instance, or
  /// update it if already exist
  Future<T> upsert(
    T data, {
    Map<String, dynamic> param = const {},
  });

  Future<void> delete(
    String id, {
    Map<String, dynamic> param = const {},
    String idKey = 'id',
  });
}
