// A widget test: it builds your app in memory and checks what is on screen.
// Run them all with: flutter test
//
// You are not required to write more of these, but a project with a few real
// tests reads very differently from one with none.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:final_project/main.dart';
import 'package:final_project/screens/home_shell.dart';

void main() {
  // Saved trips use shared_preferences, so give the tests an in-memory fake.
  setUp(() => SharedPreferences.setMockInitialValues({}));

  // A phone-sized screen so the forms fit without overflowing.
  void usePhoneScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
  }

  // Only look inside the Home screen (the other tabs stay alive in memory).
  Finder inHome(Finder f) =>
      find.descendant(of: find.byType(HomeScreen), matching: f);

  testWidgets('home screen shows the dashboard and a trip can be created',
      (tester) async {
    usePhoneScreen(tester);
    // Build the app. Note we build SpendWiseApp directly, not a DevicePreview
    // wrapper, because a test does not need the phone frame.
    await tester.pumpWidget(const SpendWiseApp());
    await tester.pumpAndSettle();

    expect(inHome(find.text('SPEND WISE')), findsOneWidget);
    expect(inHome(find.text('Good morning! 👋')), findsOneWidget);
    expect(inHome(find.text('Weekend Grocery Run')), findsOneWidget);

    // Tap New Trip, then let the new screen appear.
    await tester.tap(inHome(find.text('New Trip')));
    await tester.pumpAndSettle();
    expect(find.text('New Shopping Trip'), findsOneWidget);

    // Fill in the form and create the trip.
    await tester.enterText(find.byType(TextField).at(0), 'Test Run');
    await tester.enterText(find.byType(TextField).at(1), '1200');
    await tester.tap(find.text('Create Shopping Trip'));
    await tester.pumpAndSettle();

    // Back on Home, showing the new trip and its budget.
    expect(inHome(find.text('Test Run')), findsOneWidget);
    expect(inHome(find.text('₱1,200')), findsOneWidget);
  });

  testWidgets('history tab lists completed trips', (tester) async {
    usePhoneScreen(tester);
    await tester.pumpWidget(const SpendWiseApp());
    await tester.pumpAndSettle();

    // The bottom-nav History tab uses Icons.history.
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    expect(find.text('Shopping History'), findsOneWidget);
    expect(find.text('Monthly Essentials'), findsOneWidget);
    expect(find.text('School Supplies'), findsOneWidget);
  });
}