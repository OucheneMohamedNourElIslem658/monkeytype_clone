import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monkey_type_clone/storage/controllers/history.dart';
import 'package:monkey_type_clone/storage/models/typing_racord.dart';

class Histories extends StatelessWidget {
  const Histories({super.key});

  @override
  Widget build(BuildContext context) {
    final historiesController = Get.put(HistoriesController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              historiesController.addRecord(
                TypingRecord(
                  wpms: [],
                  numberOfErrors: [], 
                  accuracy: 99, 
                  givenWords: 500, 
                  charactersRecord: CharactersRecord(correct: 50, mistakes: 30, extra: 100), 
                  consistency: 7.5, 
                  time: DateTime.now(), 
                  review: 'good'
                )
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: GetBuilder<HistoriesController>(
            builder: (_) {
              if (historiesController.histories.isEmpty) {
                return const Center(
                  child: Text('No history yet'),
                );
              } else {
                return ListView.builder(
                  itemCount: historiesController.histories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(historiesController.histories[index].givenWords.toString()),
                    );
                  },
                );
              }
            }
          ),
        ),
      ),
    );
  }
}