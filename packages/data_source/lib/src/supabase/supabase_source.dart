import 'package:supabase_flutter/supabase_flutter.dart';

import '../factory.dart';
import '../source.dart';

class SupabaseSource<T> extends Source<T> {
  final String dbName;
  final Encoder<T> encoder;
  final Decoder<T> decoder;
  final SupabaseClient client;

  SupabaseSource({
    required this.encoder,
    required this.decoder,
    required this.dbName,
    SupabaseClient? client,
  }) : client = client ?? Supabase.instance.client;

  SupabaseQueryBuilder get _builder => client.from(dbName);

  @override
  Future<void> delete(
    String id, {
    Map<String, dynamic> param = const {},
  }) async {
    await _builder.delete().eq('id', id);
  }

  @override
  Future<T?> get(String id, {Map<String, dynamic> param = const {}}) async {
    final query = _builder.select<PostgrestMap>().eq('id', id);
    final data = await query.limit(1).single();
    return decoder(data);
  }

  @override
  Future<Iterable<T>> getAll({Map<String, dynamic> param = const {}}) async {
    final data = await _builder.select<PostgrestList>();
    return data.map(decoder);
  }

  @override
  Future<T> upsert(T data, {Map<String, dynamic> param = const {}}) async {
    final query = _builder.upsert(encoder(data));
    final newData = await query.select<PostgrestMap>().single();
    return decoder(newData);
  }
}
