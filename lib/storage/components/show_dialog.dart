import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/histories.dart';

Future<dynamic> showCustomDialog(HistoriesController historiesController) {
    return Get.defaultDialog(
      title: 'Delete all histories',
      middleText: 'Are you sure you want to delete all histories?',
      radius: 10,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          }, 
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await historiesController.clearHistories();
            Get.back();
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.blue
            ),
          ),
        )
      ],
    );
  }