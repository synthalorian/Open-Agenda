import 'package:flutter_test/flutter_test.dart';
import 'package:open_agenda_core/models/attendance.dart';

void main() {
  group('AttendanceRecord', () {
    final record = AttendanceRecord(
      id: 'r1',
      studentId: 's1',
      date: DateTime(2026, 4, 2),
      status: AttendanceStatus.present,
    );

    test('defaults', () {
      expect(record.notes, isNull);
      expect(record.periodNumber, isNull);
    });

    test('JSON round-trip', () {
      final json = record.toJson();
      final restored = AttendanceRecord.fromJson(json);
      expect(restored.id, 'r1');
      expect(restored.status, AttendanceStatus.present);
    });

    test('copyWith changes status', () {
      final absent = record.copyWith(status: AttendanceStatus.absent);
      expect(absent.status, AttendanceStatus.absent);
      expect(absent.studentId, 's1');
    });
  });

  group('AttendanceStatus', () {
    test('has 4 values', () {
      expect(AttendanceStatus.values.length, 4);
    });
  });
}
