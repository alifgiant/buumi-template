import 'package:feature_scaffold/feature_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // given
  const potrait = TestPage('potrait');
  const landscape = TestPage('landscape');
  final app = MaterialApp(
    home: DynamicLayout(
      potrait: (_, __) => potrait,
      landscape: (_, __) => landscape,
    ),
  );

  testWidgets(
    'given screen width less than height, show potrait screen',
    (widgetTester) async {
      // given
      const width = 600.0;
      const height = 800.0;
      await widgetTester.binding.setSurfaceSize(const Size(width, height));

      // when
      await widgetTester.pumpWidget(app);

      // then
      expect(find.text('potrait'), findsOneWidget);
      expect(find.text('landscape'), findsNothing);
    },
  );

  testWidgets(
    'given screen width more than height, show landscape screen',
    (widgetTester) async {
      // given
      const width = 800.0;
      const height = 600.0;
      await widgetTester.binding.setSurfaceSize(const Size(width, height));

      // when
      await widgetTester.pumpWidget(app);

      // then
      expect(find.text('potrait'), findsNothing);
      expect(find.text('landscape'), findsOneWidget);
    },
  );

  testWidgets(
    'given screen width equal to height, show potrait screen',
    (widgetTester) async {
      // given
      const width = 600.0;
      const height = 600.0;
      await widgetTester.binding.setSurfaceSize(const Size(width, height));

      // when
      await widgetTester.pumpWidget(app);

      // then
      expect(find.text('potrait'), findsOneWidget);
      expect(find.text('landscape'), findsNothing);
    },
  );
}

class TestPage extends StatelessWidget {
  final String title;
  const TestPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(title),
    );
  }
}
