import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/student.dart';
import '../models/grade.dart';
import '../models/attendance.dart';
import '../models/iep_goal.dart';

/// Neon accent palette for PDF theming.
const _cyan = PdfColor.fromInt(0xFF00F5FF);
const _pink = PdfColor.fromInt(0xFFFF006E);
const _purple = PdfColor.fromInt(0xFF8B5CF6);
const _darkRow = PdfColor.fromInt(0xFF16213E);
const _lightRow = PdfColor.fromInt(0xFF1A1A2E);
const _textPrimary = PdfColor.fromInt(0xFFE0E0E0);
const _textMuted = PdfColor.fromInt(0xFF9E9E9E);

class PdfExportService {
  PdfExportService._();

  // ---------------------------------------------------------------------------
  // Grade Report
  // ---------------------------------------------------------------------------

  static pw.Document generateGradeReport({
    required List<Student> students,
    required List<Assignment> assignments,
    required List<GradeEntry> entries,
  }) {
    final doc = pw.Document();
    final studentMap = {for (final s in students) s.id: s};
    final assignmentMap = {for (final a in assignments) a.id: a};

    // Build rows
    final rows = <_GradeRow>[];
    for (final e in entries) {
      if (e.isExcused) continue;
      final student = studentMap[e.studentId];
      final assignment = assignmentMap[e.assignmentId];
      if (student == null || assignment == null) continue;
      final pct = assignment.totalPoints > 0
          ? (e.pointsEarned / assignment.totalPoints) * 100
          : 0.0;
      rows.add(_GradeRow(
        studentName: student.fullName,
        assignmentTitle: assignment.title,
        score: '${e.pointsEarned.toStringAsFixed(1)} / ${assignment.totalPoints.toStringAsFixed(1)}',
        percentage: pct,
        letter: _letterGrade(pct),
      ));
    }

    // Summary stats
    final percentages = rows.map((r) => r.percentage).toList();
    final classAvg =
        percentages.isEmpty ? 0.0 : percentages.reduce((a, b) => a + b) / percentages.length;
    final highest = percentages.isEmpty ? 0.0 : percentages.reduce((a, b) => a > b ? a : b);
    final lowest = percentages.isEmpty ? 0.0 : percentages.reduce((a, b) => a < b ? a : b);

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        theme: _theme(),
        header: (ctx) => _header('Grade Report', ctx),
        footer: _footer,
        build: (ctx) => [
          pw.TableHelper.fromTextArray(
            context: ctx,
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
            headerDecoration: const pw.BoxDecoration(color: _purple),
            cellStyle: const pw.TextStyle(color: _textPrimary, fontSize: 9),
            cellAlignment: pw.Alignment.centerLeft,
            cellAlignments: {
              3: pw.Alignment.centerRight,
              4: pw.Alignment.center,
            },
            oddRowDecoration: const pw.BoxDecoration(color: _darkRow),

            headers: ['Student', 'Assignment', 'Score', 'Percentage', 'Grade'],
            data: rows
                .map((r) => [
                      r.studentName,
                      r.assignmentTitle,
                      r.score,
                      '${r.percentage.toStringAsFixed(1)}%',
                      r.letter,
                    ])
                .toList(),
          ),
          pw.SizedBox(height: 16),
          _summaryCard([
            'Class Average: ${classAvg.toStringAsFixed(1)}%',
            'Highest: ${highest.toStringAsFixed(1)}%',
            'Lowest: ${lowest.toStringAsFixed(1)}%',
            'Total Entries: ${rows.length}',
          ]),
        ],
      ),
    );

    return doc;
  }

  // ---------------------------------------------------------------------------
  // Attendance Report
  // ---------------------------------------------------------------------------

  static pw.Document generateAttendanceReport({
    required List<Student> students,
    required List<AttendanceRecord> records,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final doc = pw.Document();
    final fmt = DateFormat.yMMMd();
    final dateRange = '${fmt.format(startDate)} - ${fmt.format(endDate)}';

    // Filter to date range
    final filtered = records
        .where((r) => !r.date.isBefore(startDate) && !r.date.isAfter(endDate))
        .toList();

    // Per-student breakdown
    final rows = <_AttendanceRow>[];
    for (final s in students) {
      final mine = filtered.where((r) => r.studentId == s.id).toList();
      if (mine.isEmpty) continue;
      final present =
          mine.where((r) => r.status == AttendanceStatus.present).length;
      final absent =
          mine.where((r) => r.status == AttendanceStatus.absent).length;
      final tardy =
          mine.where((r) => r.status == AttendanceStatus.tardy).length;
      final excused =
          mine.where((r) => r.status == AttendanceStatus.excused).length;
      final rate = mine.isEmpty ? 0.0 : (present / mine.length) * 100;
      rows.add(_AttendanceRow(
        studentName: s.fullName,
        present: present,
        absent: absent,
        tardy: tardy,
        excused: excused,
        rate: rate,
      ));
    }

    // Overall
    final totalPresent =
        filtered.where((r) => r.status == AttendanceStatus.present).length;
    final overallRate =
        filtered.isEmpty ? 0.0 : (totalPresent / filtered.length) * 100;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        theme: _theme(),
        header: (ctx) => _header('Attendance Report', ctx, subtitle: dateRange),
        footer: _footer,
        build: (ctx) => [
          pw.TableHelper.fromTextArray(
            context: ctx,
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
            headerDecoration: const pw.BoxDecoration(color: _cyan),
            cellStyle: const pw.TextStyle(color: _textPrimary, fontSize: 9),
            cellAlignment: pw.Alignment.center,
            cellAlignments: {0: pw.Alignment.centerLeft},
            oddRowDecoration: const pw.BoxDecoration(color: _darkRow),

            headers: [
              'Student',
              'Present',
              'Absent',
              'Tardy',
              'Excused',
              'Rate %',
            ],
            data: rows
                .map((r) => [
                      r.studentName,
                      r.present.toString(),
                      r.absent.toString(),
                      r.tardy.toString(),
                      r.excused.toString(),
                      '${r.rate.toStringAsFixed(1)}%',
                    ])
                .toList(),
          ),
          pw.SizedBox(height: 16),
          _summaryCard([
            'Overall Attendance Rate: ${overallRate.toStringAsFixed(1)}%',
            'Total Records: ${filtered.length}',
            'Students: ${rows.length}',
          ]),
        ],
      ),
    );

    return doc;
  }

  // ---------------------------------------------------------------------------
  // IEP Progress Report
  // ---------------------------------------------------------------------------

  static pw.Document generateIEPProgressReport({
    required Student student,
    required List<IEPGoal> goals,
    required List<IEPProgressNote> notes,
  }) {
    final doc = pw.Document();
    final fmt = DateFormat.yMMMd();

    // Group notes by goal
    final notesByGoal = <String, List<IEPProgressNote>>{};
    for (final n in notes) {
      notesByGoal.putIfAbsent(n.goalId, () => []).add(n);
    }

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        theme: _theme(),
        header: (ctx) => _header(
          'IEP Progress Report',
          ctx,
          subtitle: student.fullName,
        ),
        footer: _footer,
        build: (ctx) {
          final widgets = <pw.Widget>[];

          for (final goal in goals) {
            final goalNotes = notesByGoal[goal.id] ?? [];
            goalNotes.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));

            widgets.add(
              pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 16),
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: _darkRow,
                  border: pw.Border.all(color: _purple, width: 0.5),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Goal header
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          goal.category.toUpperCase(),
                          style: pw.TextStyle(
                            color: _purple,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        _statusBadge(goal.status),
                      ],
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      goal.goalText,
                      style: const pw.TextStyle(color: _textPrimary, fontSize: 10),
                    ),
                    pw.SizedBox(height: 8),

                    // Meta row
                    pw.Row(children: [
                      _metaLabel('Target', fmt.format(goal.targetDate)),
                      pw.SizedBox(width: 20),
                      _metaLabel('Progress', '${goal.progressPercent.toInt()}%'),
                    ]),

                    // Accommodations
                    if (goal.accommodations.isNotEmpty) ...[
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Accommodations',
                        style: pw.TextStyle(
                          color: _cyan,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      ...goal.accommodations.map((a) => pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 8, top: 1),
                            child: pw.Text(
                              '- $a',
                              style: const pw.TextStyle(
                                  color: _textMuted, fontSize: 9),
                            ),
                          )),
                    ],

                    // Notes
                    if (goalNotes.isNotEmpty) ...[
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Progress Notes',
                        style: pw.TextStyle(
                          color: _pink,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      ...goalNotes.map((n) => pw.Container(
                            margin: const pw.EdgeInsets.only(top: 4),
                            padding: const pw.EdgeInsets.all(6),
                            decoration: const pw.BoxDecoration(
                              color: _lightRow,
                              borderRadius:
                                  pw.BorderRadius.all(pw.Radius.circular(2)),
                            ),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  width: 70,
                                  child: pw.Text(
                                    fmt.format(n.recordedAt),
                                    style: const pw.TextStyle(
                                        color: _textMuted, fontSize: 8),
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    n.note,
                                    style: const pw.TextStyle(
                                        color: _textPrimary, fontSize: 9),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 36,
                                  child: pw.Text(
                                    '${n.progressPercent.toInt()}%',
                                    style: pw.TextStyle(
                                      color: _cyan,
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                    textAlign: pw.TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ],
                ),
              ),
            );
          }

          if (widgets.isEmpty) {
            widgets.add(
              pw.Text(
                'No IEP goals on record.',
                style: const pw.TextStyle(color: _textMuted, fontSize: 10),
              ),
            );
          }

          return widgets;
        },
      ),
    );

    return doc;
  }

  // ---------------------------------------------------------------------------
  // Comprehensive Student Report
  // ---------------------------------------------------------------------------

  static pw.Document generateStudentReport({
    required Student student,
    required List<GradeEntry> grades,
    required List<Assignment> assignments,
    required List<AttendanceRecord> attendance,
    required List<IEPGoal> iepGoals,
  }) {
    final doc = pw.Document();
    final fmt = DateFormat.yMMMd();
    final assignmentMap = {for (final a in assignments) a.id: a};

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        theme: _theme(),
        header: (ctx) => _header(
          'Student Report',
          ctx,
          subtitle: '${student.fullName} - Grade ${student.grade}${student.section}',
        ),
        footer: _footer,
        build: (ctx) {
          final widgets = <pw.Widget>[];

          // --- Grades Section ---
          widgets.add(_sectionHeader('Academic Grades', _purple));
          final gradeRows = <List<String>>[];
          final percentages = <double>[];
          for (final g in grades) {
            if (g.isExcused) continue;
            final a = assignmentMap[g.assignmentId];
            if (a == null) continue;
            final pct = a.totalPoints > 0
                ? (g.pointsEarned / a.totalPoints) * 100
                : 0.0;
            percentages.add(pct);
            gradeRows.add([
              a.title,
              a.subject,
              '${g.pointsEarned.toStringAsFixed(1)} / ${a.totalPoints.toStringAsFixed(1)}',
              '${pct.toStringAsFixed(1)}%',
              _letterGrade(pct),
            ]);
          }

          if (gradeRows.isNotEmpty) {
            widgets.add(pw.TableHelper.fromTextArray(
              context: ctx,
              headerStyle: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9),
              headerDecoration: const pw.BoxDecoration(color: _purple),
              cellStyle:
                  const pw.TextStyle(color: _textPrimary, fontSize: 8),
              oddRowDecoration: const pw.BoxDecoration(color: _darkRow),
  
              headers: ['Assignment', 'Subject', 'Score', '%', 'Grade'],
              data: gradeRows,
            ));
            final avg = percentages.reduce((a, b) => a + b) / percentages.length;
            widgets.add(pw.SizedBox(height: 6));
            widgets.add(pw.Text(
              'GPA Average: ${avg.toStringAsFixed(1)}% (${_letterGrade(avg)})',
              style: pw.TextStyle(
                  color: _cyan, fontWeight: pw.FontWeight.bold, fontSize: 10),
            ));
          } else {
            widgets.add(pw.Text('No grade entries.',
                style: const pw.TextStyle(color: _textMuted, fontSize: 9)));
          }

          widgets.add(pw.SizedBox(height: 16));

          // --- Attendance Section ---
          widgets.add(_sectionHeader('Attendance', _cyan));
          if (attendance.isNotEmpty) {
            final present =
                attendance.where((r) => r.status == AttendanceStatus.present).length;
            final absent =
                attendance.where((r) => r.status == AttendanceStatus.absent).length;
            final tardy =
                attendance.where((r) => r.status == AttendanceStatus.tardy).length;
            final excused =
                attendance.where((r) => r.status == AttendanceStatus.excused).length;
            final rate = (present / attendance.length) * 100;

            widgets.add(pw.TableHelper.fromTextArray(
              context: ctx,
              headerStyle: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9),
              headerDecoration: const pw.BoxDecoration(color: _cyan),
              cellStyle:
                  const pw.TextStyle(color: _textPrimary, fontSize: 9),
              oddRowDecoration: const pw.BoxDecoration(color: _darkRow),
  
              headers: ['Present', 'Absent', 'Tardy', 'Excused', 'Rate'],
              data: [
                [
                  present.toString(),
                  absent.toString(),
                  tardy.toString(),
                  excused.toString(),
                  '${rate.toStringAsFixed(1)}%',
                ]
              ],
            ));
          } else {
            widgets.add(pw.Text('No attendance records.',
                style: const pw.TextStyle(color: _textMuted, fontSize: 9)));
          }

          widgets.add(pw.SizedBox(height: 16));

          // --- IEP Section ---
          if (iepGoals.isNotEmpty) {
            widgets.add(_sectionHeader('IEP Goals', _pink));
            for (final goal in iepGoals) {
              widgets.add(pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 8),
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: _darkRow,
                  border: pw.Border.all(color: _pink, width: 0.5),
                  borderRadius: pw.BorderRadius.circular(3),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(goal.category.toUpperCase(),
                            style: pw.TextStyle(
                                color: _pink,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9)),
                        _statusBadge(goal.status),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(goal.goalText,
                        style: const pw.TextStyle(
                            color: _textPrimary, fontSize: 9)),
                    pw.SizedBox(height: 4),
                    pw.Row(children: [
                      _metaLabel('Target', fmt.format(goal.targetDate)),
                      pw.SizedBox(width: 16),
                      _metaLabel('Progress', '${goal.progressPercent.toInt()}%'),
                    ]),
                  ],
                ),
              ));
            }
          }

          return widgets;
        },
      ),
    );

    return doc;
  }

  // ---------------------------------------------------------------------------
  // Shared helpers
  // ---------------------------------------------------------------------------

  static pw.ThemeData _theme() {
    return pw.ThemeData(
      defaultTextStyle: const pw.TextStyle(color: _textPrimary, fontSize: 10),
    );
  }

  static pw.Widget _header(String title, pw.Context ctx, {String? subtitle}) {
    final fmt = DateFormat.yMMMMd();
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 12),
      margin: const pw.EdgeInsets.only(bottom: 12),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _cyan, width: 1)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Open Agenda',
                style: pw.TextStyle(
                  color: _cyan,
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                title,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (subtitle != null)
                pw.Text(
                  subtitle,
                  style: const pw.TextStyle(color: _textMuted, fontSize: 10),
                ),
            ],
          ),
          pw.Text(
            'Generated ${fmt.format(DateTime.now())}',
            style: const pw.TextStyle(color: _textMuted, fontSize: 8),
          ),
        ],
      ),
    );
  }

  static pw.Widget _footer(pw.Context ctx) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: _purple, width: 0.5)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Open Agenda',
            style: pw.TextStyle(
              color: _purple,
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            'Page ${ctx.pageNumber} of ${ctx.pagesCount}',
            style: const pw.TextStyle(color: _textMuted, fontSize: 8),
          ),
        ],
      ),
    );
  }

  static pw.Widget _summaryCard(List<String> lines) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _darkRow,
        border: pw.Border.all(color: _cyan, width: 0.5),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Summary',
            style: pw.TextStyle(
              color: _cyan,
              fontWeight: pw.FontWeight.bold,
              fontSize: 11,
            ),
          ),
          pw.SizedBox(height: 4),
          ...lines.map((l) => pw.Padding(
                padding: const pw.EdgeInsets.only(top: 2),
                child:
                    pw.Text(l, style: const pw.TextStyle(color: _textPrimary, fontSize: 9)),
              )),
        ],
      ),
    );
  }

  static pw.Widget _sectionHeader(String text, PdfColor color) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      padding: const pw.EdgeInsets.only(bottom: 4),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: color, width: 0.5)),
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _statusBadge(GoalStatus status) {
    PdfColor color;
    switch (status) {
      case GoalStatus.active:
        color = _cyan;
        break;
      case GoalStatus.met:
        color = const PdfColor.fromInt(0xFF00E676);
        break;
      case GoalStatus.notMet:
        color = _pink;
        break;
      case GoalStatus.revised:
        color = const PdfColor.fromInt(0xFFFF9800);
        break;
    }
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: pw.BorderRadius.circular(3),
      ),
      child: pw.Text(
        status.name.toUpperCase(),
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 7,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _metaLabel(String label, String value) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '$label: ',
            style: const pw.TextStyle(color: _textMuted, fontSize: 9),
          ),
          pw.TextSpan(
            text: value,
            style: pw.TextStyle(
              color: _textPrimary,
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static String _letterGrade(double pct) {
    if (pct >= 93) return 'A';
    if (pct >= 90) return 'A-';
    if (pct >= 87) return 'B+';
    if (pct >= 83) return 'B';
    if (pct >= 80) return 'B-';
    if (pct >= 77) return 'C+';
    if (pct >= 73) return 'C';
    if (pct >= 70) return 'C-';
    if (pct >= 67) return 'D+';
    if (pct >= 63) return 'D';
    if (pct >= 60) return 'D-';
    return 'F';
  }
}

// Internal data classes for table building
class _GradeRow {
  final String studentName;
  final String assignmentTitle;
  final String score;
  final double percentage;
  final String letter;

  _GradeRow({
    required this.studentName,
    required this.assignmentTitle,
    required this.score,
    required this.percentage,
    required this.letter,
  });
}

class _AttendanceRow {
  final String studentName;
  final int present;
  final int absent;
  final int tardy;
  final int excused;
  final double rate;

  _AttendanceRow({
    required this.studentName,
    required this.present,
    required this.absent,
    required this.tardy,
    required this.excused,
    required this.rate,
  });
}
