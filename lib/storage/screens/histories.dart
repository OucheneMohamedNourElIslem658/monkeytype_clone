import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/record_item.dart';
import '../components/show_dialog.dart';
import '../controllers/histories.dart';

class Histories extends StatelessWidget {
  const Histories({super.key});

  @override
  Widget build(BuildContext context) {
    final historiesController = Get.put(HistoriesController());
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 65, 65),
        title: const Text(
          'Histories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,

          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () async => await showCustomDialog(historiesController),
          )
        ],
      ),

      body: GetBuilder<HistoriesController>(
        builder: (_) {
          if (historiesController.histories.isEmpty) {
            return const Center(
              child: Text('No histories yet'),
            );
          } else {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: ListView.builder(
                  itemCount: historiesController.histories.length,
                  itemBuilder: (context, index) {
                    final history = historiesController.histories[index];
                    return RecordItem(
                      history: history, 
                      index: index,
                      historiesController: historiesController
                    );
                  },
                ),
              ),
            );
          }
        },
      )
    );
  }
}