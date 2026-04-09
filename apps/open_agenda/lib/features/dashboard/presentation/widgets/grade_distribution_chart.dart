import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:open_agenda_core/open_agenda_core.dart';

/// Bar chart showing grade distribution across standard letter-grade ranges.
/// Expects [percentages] — a flat list of percentage scores (0-100) for every
/// grade entry in the system.
class GradeDistributionChart extends StatelessWidget {
  final List<double> percentages;

  const GradeDistributionChart({super.key, required this.percentages});

  @override
  Widget build(BuildContext context) {
    final buckets = _computeBuckets();

    return GlassCard(
      title: 'Grade Distribution',
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: SizedBox(
        height: 200,
        child: percentages.isEmpty
            ? Center(
                child: Text(
                  'No grade data yet',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textTertiary),
                ),
              )
            : BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _maxY(buckets),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final labels = ['A', 'B', 'C', 'D', 'F'];
                        return BarTooltipItem(
                          '${labels[group.x]}: ${rod.toY.toInt()} students',
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
                          const labels = ['A', 'B', 'C', 'D', 'F'];
                          final idx = value.toInt();
                          if (idx < 0 || idx >= labels.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[idx],
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
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
                        reservedSize: 32,
                        interval: _yInterval(buckets),
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const SizedBox.shrink();
                          return Text(
                            value.toInt().toString(),
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
                    horizontalInterval: _yInterval(buckets),
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.glassBorder.withOpacity(0.3),
                      strokeWidth: 0.5,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(5, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: buckets[i].toDouble(),
                          width: 28,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6)),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.neonCyan,
                              AppColors.neonPink,
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

  /// Returns [A, B, C, D, F] student counts.
  List<int> _computeBuckets() {
    int a = 0, b = 0, c = 0, d = 0, f = 0;
    for (final pct in percentages) {
      if (pct >= 90) {
        a++;
      } else if (pct >= 80) {
        b++;
      } else if (pct >= 70) {
        c++;
      } else if (pct >= 60) {
        d++;
      } else {
        f++;
      }
    }
    return [a, b, c, d, f];
  }

  double _maxY(List<int> buckets) {
    final max = buckets.fold<int>(0, (m, v) => v > m ? v : m);
    return (max + 2).toDouble();
  }

  double _yInterval(List<int> buckets) {
    final max = _maxY(buckets);
    if (max <= 5) return 1;
    if (max <= 20) return 5;
    return (max / 4).ceilToDouble();
  }
}
