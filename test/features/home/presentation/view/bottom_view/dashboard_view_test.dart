import 'package:chitto_tatto/features/home/presentation/view/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dashboard view', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardScreen(),
    ));

    await tester.pumpAndSettle();

    expect(find.text("Burger"), findsOneWidget);

    await tester.pumpAndSettle();

    // var onlyTextField = find.byType(TextField).at(0);

    // expect(onlyTextField, findsOneWidget);
  });
}
