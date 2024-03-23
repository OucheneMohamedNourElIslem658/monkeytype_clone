import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class Record extends StatelessWidget {
  const Record({
    super.key, 
    required this.wpm, 
    required this.acc, 
    required this.consistency, 
    required this.takenTime, 
    required this.review, 
    required this.comparision, 
    required this.testType, 
    required this.correctAnsswersEverySecond, 
    required this.mistakesEverySecond,
    required this.when, 
    required this.extraCaracter, 
    required this.correctCaracters, 
    required this.mistakes
  });

  final int wpm,acc,consistency,takenTime,extraCaracter,correctCaracters,mistakes;
  final String review,comparision,testType;
  final List<int> correctAnsswersEverySecond,mistakesEverySecond;
  final DateTime when;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 65, 65),
        leading: IconButton(
          onPressed:() => Get.back(), 
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
        title: const Text(
          'Record',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TypingCharts(
                correctAnsswersEverySecond: correctAnsswersEverySecond,
                mistakesEverySecond: mistakesEverySecond,
              ),
            ),
            const SizedBox(height: 30),
            LayoutBuilder(
              builder: (context,constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatisticItem(
                          title: 'characters', 
                          value: '$correctCaracters / $mistakes / $extraCaracter',
                        ),
                        devider(),
                        StatisticItem(
                          title: 'contistency',
                          value: '$consistency%',
                        ),
                        devider(),
                        StatisticItem(
                          title: 'time',
                          value: '$takenTime S',
                        ),
                        devider(),
                        StatisticItem(
                          title: 'wpm',
                          value: wpm.toString()
                        ),
                        devider(),
                        StatisticItem(
                          title: 'acc',
                          value: '$acc%'
                        ),
                        devider(),
                        StatisticItem(
                          title: 'test type',
                          value: testType.toString(),
                        ),
                      ],
                    ),
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }

  Container devider() => Container(
    height: 70,
    width: 3,
    color: Colors.black,
    margin: const EdgeInsets.symmetric(horizontal: 40),
  );
}

class StatisticItem extends StatelessWidget {
  const StatisticItem({
    super.key,
    required this.value,
    required this.title, 
    this.titleSize, 
    this.valueSize
  });

  final String value,title;
  final double? titleSize,valueSize;
  

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              fontSize: titleSize ?? 30,
              color: Colors.grey[300]
            )
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: valueSize ?? 50,
              color: Colors.yellow,
              fontWeight: FontWeight.w600
            )
          )
        ]
      )
    );
  }
}

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