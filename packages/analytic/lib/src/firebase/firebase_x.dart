import 'package:firebase_core/firebase_core.dart';

import 'firebase_setup.dart'
    if (dart.library.io) 'firebase_mobile.dart'
    if (dart.library.js) 'firebase_web.dart';

mixin FirebaseX {
  static Future? setup(FirebaseOptions option) {
    return setupFirebase(option);
  }
}
