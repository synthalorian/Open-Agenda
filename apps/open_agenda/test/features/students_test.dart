import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

import 'package:open_agenda/features/students/presentation/screens/students_screen.dart';
import 'package:open_agenda/features/students/presentation/providers/students_providers.dart';

final _testStudents = [
  Student(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    grade: 10,
    section: 'A',
    hasIEP: false,
    createdAt: DateTime(2026, 1, 1),
  ),
  Student(
    id: '2',
    firstName: 'Jane',
    lastName: 'Smith',
    grade: 11,
    section: 'B',
    hasIEP: true,
    createdAt: DateTime(2026, 1, 1),
  ),
];

void main() {
  group('StudentsScreen', () {
    testWidgets('shows student list', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredStudentsProvider
                .overrideWith((ref) => Future.value(_testStudents)),
          ],
          child: const MaterialApp(
            home: StudentsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
      expect(find.text('IEP'), findsOneWidget);
    });

    testWidgets('shows empty state when no students', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredStudentsProvider
                .overrideWith((ref) => Future.value(<Student>[])),
          ],
          child: const MaterialApp(
            home: StudentsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No students found'), findsOneWidget);
    });

    testWidgets('has search bar', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            filteredStudentsProvider
                .overrideWith((ref) => Future.value(_testStudents)),
          ],
          child: const MaterialApp(
            home: StudentsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
