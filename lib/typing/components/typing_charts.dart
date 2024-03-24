import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TypingCharts extends StatelessWidget {
  const TypingCharts({
    super.key, 
    required this.correctAnsswersEverySecond, 
    required this.mistakesEverySecond
  });

  final List<int> correctAnsswersEverySecond,mistakesEverySecond;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          show: true,
          border: const Border(
            top: BorderSide(color: Colors.transparent),
            right: BorderSide(color: Colors.transparent),
            left: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black),
          )
        ),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 3
            )
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        lineTouchData: const LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.transparent,
          )
            
        ),
        lineBarsData: [
          LineChartBarData(
            color: const Color.fromARGB(255, 68, 68, 68),
            isCurved: true,
            spots: List.generate(
              correctAnsswersEverySecond.length, 
              (index) => FlSpot(
                index *3, 
                correctAnsswersEverySecond[index].toDouble()
              )
            ),
            dotData: FlDotData(
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                radius: 5,
                color: Colors.black
              )
            ),
          ),
          LineChartBarData(
            isCurved: true,
            barWidth: 0,
            dotData: FlDotData(
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                radius: 5,
                color: Colors.red
              )
            ),
            spots: List.generate(
              mistakesEverySecond.length, 
              (index) => FlSpot(
                index * 3, 
                mistakesEverySecond[index].toDouble()
              )
            )
          )
        ]
      )
    );
  }
}