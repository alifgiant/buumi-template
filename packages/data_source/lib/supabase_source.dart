library supabase_source;

import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'src/supabase/supabase_source.dart';

class SupabaseFeature extends Feature with FSetup {
  final String url;
  final String anon;

  SupabaseFeature({required this.url, required this.anon});

  @override
  Future<void> initialize() async {
    await Supabase.initialize(url: url, anonKey: anon);
  }

  static final provider = Provider((ref) => Supabase.instance);
}
