// views/relatorio/relatorio_atividades_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart

class RelatorioAtividadesScreen extends StatefulWidget { // Changed to StatefulWidget
  const RelatorioAtividadesScreen({super.key});

  @override
  State<RelatorioAtividadesScreen> createState() => _RelatorioAtividadesScreenState();
}

class _RelatorioAtividadesScreenState extends State<RelatorioAtividadesScreen> {
  // Example data for the bar chart
  final double _barWidth = 22;
  final List<BarChartGroupData> _barGroups = [
    // Example data for Monday (index 0)
    _makeGroupData(0, musculacao: 2, jiuJitsu: 3, natacao: 1.5),
    // Example data for Tuesday (index 1)
    _makeGroupData(1, musculacao: 1, jiuJitsu: 0, natacao: 4),
    // Example data for Wednesday (index 2)
    _makeGroupData(2, musculacao: 4, jiuJitsu: 1, natacao: 1),
    // Example data for Thursday (index 3)
    _makeGroupData(3, musculacao: 1.5, jiuJitsu: 3.5, natacao: 0),
    // Example data for Friday (index 4)
    _makeGroupData(4, musculacao: 3, jiuJitsu: 0, natacao: 2.5),
    // Example data for Saturday (index 5)
    _makeGroupData(5, musculacao: 0, jiuJitsu: 5, natacao: 1),
    // Example data for Sunday (index 6)
    _makeGroupData(6, musculacao: 1, jiuJitsu: 1, natacao: 3),
  ];

  // Helper function to create BarChartGroupData
  static BarChartGroupData _makeGroupData(int x, {
    required double musculacao,
    required double jiuJitsu,
    required double natacao,
  }) {
    // Define colors based on the legend in the image
    const colorMusculacao = Color(0xFFE57373); // Reddish
    const colorJiuJitsu = Color(0xFFFFB74D); // Orange
    const colorNatacao = Color(0xFF81C784); // Greenish

    // Calculate total height for stacking
    final totalY = musculacao + jiuJitsu + natacao;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: totalY,
          width: 22, // Bar width
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          rodStackItems: [
            // Stack items in order
            BarChartRodStackItem(0, musculacao, colorMusculacao),
            BarChartRodStackItem(musculacao, musculacao + jiuJitsu, colorJiuJitsu),
            BarChartRodStackItem(musculacao + jiuJitsu, totalY, colorNatacao),
          ],
        ),
      ],
    );
  }

  // Helper widget for the legend
  Widget _buildLegend(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(const Color(0xFFE57373), 'Musculação', textColor),
        const SizedBox(width: 16),
        _legendItem(const Color(0xFFFFB74D), 'Jiu-jitsu', textColor),
        const SizedBox(width: 16),
        _legendItem(const Color(0xFF81C784), 'Natação', textColor),
      ],
    );
  }

  Widget _legendItem(Color color, String text, Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: textColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color backgroundColor = Theme.of(context).colorScheme.background;
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color gridColor = textColor.withOpacity(0.1);
    final Color tooltipBgColor = Colors.grey.shade800;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Atividades'),
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo Semanal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Aqui podem entrar cards com resumos (ex: total de treinos, calorias, etc.).',
                  style: TextStyle(color: textColor.withOpacity(0.8)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Distribuição Diária (Exemplo)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16), // Add more top padding
                child: Column(
                  children: [
                    SizedBox(
                      height: 200, // Chart height
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 8, // Adjust based on max possible total hours/value
                          minY: 0,
                          groupsSpace: 12,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                               // Use tooltipBgColor based on docs
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                String weekDay;
                                switch (group.x.toInt()) {
                                  case 0: weekDay = 'Seg'; break;
                                  case 1: weekDay = 'Ter'; break;
                                  case 2: weekDay = 'Qua'; break;
                                  case 3: weekDay = 'Qui'; break;
                                  case 4: weekDay = 'Sex'; break;
                                  case 5: weekDay = 'Sáb'; break;
                                  case 6: weekDay = 'Dom'; break;
                                  default: throw Error();
                                }
                                // Display total hours for the day
                                return BarTooltipItem(
                                  '$weekDay\n',
                                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: (rod.toY).toStringAsFixed(1) + 'h',
                                      style: const TextStyle(color: Colors.yellow, fontSize: 14),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  String text;
                                  switch (value.toInt()) {
                                    case 0: text = 'S'; break;
                                    case 1: text = 'T'; break;
                                    case 2: text = 'Q'; break;
                                    case 3: text = 'Q'; break;
                                    case 4: text = 'S'; break;
                                    case 5: text = 'S'; break;
                                    case 6: text = 'D'; break;
                                    default: text = ''; break;
                                  }
                                  return SideTitleWidget(axisSide: meta.axisSide, space: 4, child: Text(text, style: TextStyle(color: textColor, fontSize: 12)));
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                interval: 2, // Show labels every 2 hours
                                getTitlesWidget: (value, meta) {
                                  if (value == 0 || value == meta.max) return Container(); // Hide min/max
                                  return Text('${value.toInt()}h', style: TextStyle(color: textColor, fontSize: 10), textAlign: TextAlign.left);
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(
                            show: false, // Hide chart border
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 2,
                            getDrawingHorizontalLine: (value) => FlLine(color: gridColor, strokeWidth: 1),
                          ),
                          barGroups: _barGroups,
                        ),
                        swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear, // Optional
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLegend(context), // Add the legend widget
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

