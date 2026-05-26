import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ascend_landing/main.dart';

void main() {
  testWidgets('Landing page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AscendApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
