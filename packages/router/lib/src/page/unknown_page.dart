import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router/src/common_path.dart';
import 'package:router/src/route_info.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Unknown Page'),
      ),
    );
  }

  static final routeInfo = RouteInfo(
    path: CommonPath.unknown,
    routeBuilder: (path) => GoRoute(
      path: path,
      builder: (_, __) => const UnknownPage(),
    ),
  );
}




// enum AppPath {
//   // auth
//   login('/login'),
//   forgotPass('/forgot-pass'),
//   register('/register'),

//   // cashier
//   cashier('/cashier'),

//   // member
//   member('/member'),

//   // stock
//   stock('/stock'),
//   transaction('/transaction'),
//   distributor('/distributor'),

//   // journal
//   journal('/journal'),

//   // report
//   report('/report'),

//   // employee
//   employee('/employee'),

//   // branch
//   branch('/branch'),

//   // common
//   splash('/'),
//   unknown('/404'),
//   home('/home');

//   final String key;
//   const AppPath(this.key);

//   static AppPath parse(String key) {
//     return AppPath.values.firstWhere(
//       (e) => e.key == key,
//       orElse: () => AppPath.splash,
//     );
//   }
// }
