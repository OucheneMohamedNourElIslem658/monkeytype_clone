import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monkey_type_clone/typing/screens/record.dart';

import '../controllers/histories.dart';
import '../models/history.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    required this.history,
    required this.historiesController, 
    required this.index,
  });

  final History history;
  final HistoriesController historiesController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ]
      ),
      child: ListTile(
        title: Text('WPM: ${history.wpm}'),
        subtitle: Text('${history.when.day}/${history.when.month}/${history.when.year} ${history.when.hour}:${history.when.minute}'),
        onTap: () => Get.to(
          Record(
            wpm: history.wpm, 
            acc: history.acc, 
            consistency: history.consistency, 
            takenTime: history.takenTime, 
            review: history.review, 
            comparision: history.comparision, 
            testType: history.testType, 
            correctAnsswersEverySecond: history.correctAnsswersEverySecond, 
            mistakesEverySecond: history.mistakesEverySecond, 
            when: history.when, 
            extraCaracter: history.extraCaracter, 
            correctCaracters: history.correctCaracters, 
            mistakes: history.mistakes,
            showSaveButton: false,
          )
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () async {
            await historiesController.deleteHistory(index);
          },
        ),
      ),
    );
  }
}