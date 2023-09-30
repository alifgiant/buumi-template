import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_setup.dart'
    if (dart.library.io) 'firebase_mobile.dart'
    if (dart.library.js) 'firebase_web.dart';

class FirebaseX extends Feature with FSetup {
  final FirebaseOptions option;

  const FirebaseX({required this.option});

  @override
  Future<void> initialize() async {
    await setupFirebase(option);
  }
}
