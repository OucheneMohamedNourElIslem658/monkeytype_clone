import 'package:flutter/material.dart';
import '../controllers/typing_configiration_bar.dart';

class TextToTypeField extends StatelessWidget {
  const TextToTypeField({
    super.key,
    required this.typingController,
  });

  final TypingConfigirationBarController typingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      maxLength: typingController.textToType.length,
      buildCounter: (_, {required int currentLength, required bool isFocused, required int? maxLength}) => const SizedBox(),
      scrollPhysics: const NeverScrollableScrollPhysics(),
      autofocus: true,
      cursorWidth: 3,
      showCursor: true,
      scrollController: typingController.textToTypeScrollController,
      controller: TextEditingController(
        text: typingController.textToType
      ),
      enabled: false,
      style:const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600
      ),
      decoration: const InputDecoration(
        disabledBorder: InputBorder.none
      ),
    );
  }
}