import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import 'package:open_agenda/features/iep/presentation/screens/iep_screen.dart';
import 'package:open_agenda/features/iep/presentation/providers/iep_providers.dart';

final _testGoals = [
  IEPGoal(
    id: 'g1',
    studentId: 's1',
    goalText: 'Improve reading comprehension',
    category: 'Reading',
    targetDate: DateTime(2026, 7, 1),
    progressPercent: 65,
    createdAt: DateTime(2026, 4, 1),
  ),
  IEPGoal(
    id: 'g2',
    studentId: 's2',
    goalText: 'Master multi-step word problems',
    category: 'Math',
    targetDate: DateTime(2026, 7, 1),
    progressPercent: 80,
    createdAt: DateTime(2026, 4, 1),
  ),
];

void main() {
  group('IEPDashboardScreen', () {
    testWidgets('shows goal list', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredIEPGoalsProvider
                .overrideWith((ref) => Future.value(_testGoals)),
            allStudentsProvider
                .overrideWith((ref) => Future.value(<Student>[])),
          ],
          child: const MaterialApp(
            home: IEPDashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Improve reading comprehension'), findsOneWidget);
      expect(find.text('Master multi-step word problems'), findsOneWidget);
      expect(find.text('Reading'), findsOneWidget);
      expect(find.text('Math'), findsOneWidget);
    });

    testWidgets('shows empty state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredIEPGoalsProvider
                .overrideWith((ref) => Future.value(<IEPGoal>[])),
            allStudentsProvider
                .overrideWith((ref) => Future.value(<Student>[])),
          ],
          child: const MaterialApp(
            home: IEPDashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No IEP goals'), findsOneWidget);
    });

    testWidgets('has filter chips', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredIEPGoalsProvider
                .overrideWith((ref) => Future.value(_testGoals)),
            allStudentsProvider
                .overrideWith((ref) => Future.value(<Student>[])),
          ],
          child: const MaterialApp(
            home: IEPDashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Due Soon'), findsOneWidget);
      expect(find.text('Met'), findsOneWidget);
    });
  });
}
