import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/typing/components/typing_configration_bar.dart';
import '/storage/screens/histories.dart';
import '../controllers/typing_configiration_bar.dart';

import '../components/record_updates.dart';
import '../components/text_to_type_text_field.dart';
import '../components/typed_text_field.dart';


class Typing extends StatelessWidget {
  const Typing({super.key});

  @override
  Widget build(BuildContext context) {
    final typingController = Get.put(TypingConfigirationBarController());

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TypingConfigirationBar(typingController: typingController),
            GetBuilder<TypingConfigirationBarController>(
              builder: (_) {
                return SizedBox(
                  width: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          !typingController.startTyping
                          ? IconButton(
                            onPressed: () => Get.to(const Histories()), 
                            icon: const Icon(
                              Icons.list,
                              size: 30,
                            )
                          )
                          : const SizedBox(),
                          const Spacer(),
                          RecordUpdates(typingController: typingController),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => typingController.focusOnField(),
                        child: Stack(
                          children: [
                            TextToTypeField(typingController: typingController),
                            TypedTextField(typingController: typingController),
                            Positioned.fill(child: Container(color: Colors.transparent))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
            IconButton(
              onPressed: () {
                if (typingController.isWordsSelected) {
                  typingController.resetWords();
                } else {
                  typingController.resetTime();
                }
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
      ),
    );
  }
}