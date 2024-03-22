import 'package:flutter/material.dart';

import '../controllers/typing_configiration_bar.dart';

class TypedTextField extends StatelessWidget {
  const TypedTextField({
    super.key,
    required this.typingController,
  });

  final TypingConfigirationBarController typingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 2,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600
      ),
      enableInteractiveSelection: false,
      maxLength: typingController.textToType.length,
      autofocus: true,
      cursorWidth: 3,
      showCursor: true,
      controller: typingController.controller,
      scrollController: typingController.typedTextScrollController,
      focusNode: typingController.typedTextFocusNode,
      onChanged: (value) {
        if (typingController.isWordsSelected) {
          typingController.keepTrackWords(value);
        } else {
          typingController.keepTrackTime(value);
        }
      },
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        counter: SizedBox()
      ),
    );
  }
}