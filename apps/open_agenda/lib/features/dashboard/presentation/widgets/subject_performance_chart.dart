import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

/// Horizontal bar chart showing average grade per subject.
/// [subjectAverages] maps subject name -> average percentage (0-100).
class SubjectPerformanceChart extends StatelessWidget {
  final Map<String, double> subjectAverages;

  const SubjectPerformanceChart({
    super.key,
    required this.subjectAverages,
  });

  static const _subjectColors = {
    'math': AppColors.mathColor,
    'science': AppColors.scienceColor,
    'english': AppColors.englishColor,
    'history': AppColors.historyColor,
  };

  Color _colorFor(String subject) {
    return _subjectColors[subject.toLowerCase()] ?? AppColors.neonPurple;
  }

  @override
  Widget build(BuildContext context) {
    final entries = subjectAverages.entries.toList();

    return GlassCard(
      title: 'Subject Performance',
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: SizedBox(
        height: 200,
        child: entries.isEmpty
            ? Center(
                child: Text(
                  'No subject data yet',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textTertiary),
                ),
              )
            : BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final entry = entries[group.x];
                        return BarTooltipItem(
                          '${entry.key}: ${entry.value.toStringAsFixed(1)}%',
                          const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= entries.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              _capitalize(entries[idx].key),
                              style: TextStyle(
                                color: _colorFor(entries[idx].key),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        interval: 25,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}%',
                            style: const TextStyle(
                              color: AppColors.textTertiary,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.glassBorder.withOpacity(0.3),
                      strokeWidth: 0.5,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(entries.length, (i) {
                    final color = _colorFor(entries[i].key);
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: entries[i].value,
                          width: 28,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6)),
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.7),
                              color,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
