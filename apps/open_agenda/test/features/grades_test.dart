import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import 'package:open_agenda/features/grades/presentation/screens/grades_screen.dart';
import 'package:open_agenda/features/grades/presentation/providers/grades_providers.dart';

final _testAssignments = [
  Assignment(
    id: 'a1',
    title: 'Chapter 5 Quiz',
    subject: 'Math',
    dueDate: DateTime(2026, 4, 15),
    totalPoints: 20,
    category: AssignmentCategory.quiz,
    createdAt: DateTime(2026, 4, 1),
  ),
  Assignment(
    id: 'a2',
    title: 'Lab Report',
    subject: 'Science',
    dueDate: DateTime(2026, 4, 16),
    totalPoints: 50,
    category: AssignmentCategory.project,
    createdAt: DateTime(2026, 4, 1),
  ),
];

void main() {
  group('GradesScreen', () {
    testWidgets('shows assignment list', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            assignmentsBySubjectProvider
                .overrideWith((ref) => Future.value(_testAssignments)),
          ],
          child: const MaterialApp(
            home: GradesScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Chapter 5 Quiz'), findsOneWidget);
      expect(find.text('Lab Report'), findsOneWidget);
    });

    testWidgets('shows empty state when no assignments', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            assignmentsBySubjectProvider
                .overrideWith((ref) => Future.value(<Assignment>[])),
          ],
          child: const MaterialApp(
            home: GradesScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No assignments'), findsOneWidget);
    });

    testWidgets('has subject filter chips', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            assignmentsBySubjectProvider
                .overrideWith((ref) => Future.value(_testAssignments)),
          ],
          child: const MaterialApp(
            home: GradesScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Math'), findsOneWidget);
      expect(find.text('Science'), findsOneWidget);
    });
  });
}
