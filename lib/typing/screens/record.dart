import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/typing.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    final typingController = Get.find<TypingController>();

    return Scaffold(
      body: Column(
        children: [
          Text(
            'mistakes : ${typingController.totalMistakes}/ tapedCaracters : ${typingController.typedCaractersNumber}'
          ),
          Text('finalResult : ${typingController.correctAnswers} / typedText : ${typingController.textToType.length}'),
          Text(
            typingController.getTime()
          ),
        ],
      )
    );
  }
}