import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../storage/controllers/histories.dart';
import '../../storage/models/history.dart';
import '../components/statistic_items.dart';
import '../components/typing_charts.dart';

// ignore: must_be_immutable
class Record extends StatelessWidget {
  Record({
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
    required this.mistakes,
    this.showSaveButton = true
  });

  final int wpm,acc,consistency,takenTime,extraCaracter,correctCaracters,mistakes;
  final String review,comparision,testType;
  final List<int> correctAnsswersEverySecond,mistakesEverySecond;
  final DateTime when;
  final bool showSaveButton;

  var historiesController = Get.put(HistoriesController());

  void addRecord() async {
    try {
      await historiesController.addHistory(History(
        wpm: wpm,
        acc: acc,
        consistency: consistency,
        takenTime: takenTime,
        review: review,
        comparision: comparision,
        testType: testType,
        correctAnsswersEverySecond: correctAnsswersEverySecond,
        mistakesEverySecond: mistakesEverySecond,
        when: when,
        extraCaracter: extraCaracter,
        correctCaracters: correctCaracters,
        mistakes: mistakes
      ));
      Get.snackbar('Success', 'Record added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add record');
    }
  }


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
        actions: showSaveButton 
        ? [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () => addRecord(), 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16)
              ),
              child: const Row(
                children: [
                  Icon(Icons.save,color: Colors.black,),
                  SizedBox(width: 10),
                  Text(
                    'save record',
                    style: TextStyle(
                      color: Colors.black,
                    )
                  )
                ],
              )
            ),
          )
        ]
        : [],
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