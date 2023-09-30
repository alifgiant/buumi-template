typedef Decoder<T> = T Function(Map<String, dynamic> json);
typedef Encoder<T> = Map<String, dynamic> Function(T data);

extension JsonX on Map<String, dynamic> {
  T unpack<T>(String key, {required T defaultValue}) {
    return this[key] ?? defaultValue;
  }

  Iterable<T> unpackList<T>(
    String key, {
    required Decoder<T> decoder,
    Iterable<T> defaultValue = const [],
  }) {
    final rawList = this[key] as List?;
    if (rawList == null) return defaultValue;

    final list = List<Map<String, dynamic>>.from(rawList);
    return list.map((e) => decoder(e)).toList();
  }
}
