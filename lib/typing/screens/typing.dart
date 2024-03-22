import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monkey_type_clone/storage/screens/histories.dart';
import 'package:monkey_type_clone/typing/controllers/typing.dart';


class Typing extends StatelessWidget {
  const Typing({super.key});

  @override
  Widget build(BuildContext context) {
    final typingController = Get.put(TypingController());

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<TypingController>(
                builder: (_) {
                  return Column(
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
                  );
                }
              ),
              IconButton(
                onPressed: () {
                  typingController.reset();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecordUpdates extends StatelessWidget {
  const RecordUpdates({
    super.key,
    required this.typingController,
  });

  final TypingController typingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${typingController.typedText.split(' ').length-1} / ${typingController.textToType.split(' ').length-1}'
        ),
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()), 
          builder:(_, snapshot) {
            if (typingController.startTyping) {
              return Text(' | ${DateTime.now().difference(typingController.startTime!).inSeconds}');
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}

class TypedTextField extends StatelessWidget {
  const TypedTextField({
    super.key,
    required this.typingController,
  });

  final TypingController typingController;

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
        typingController.keepTrack(value);
      },
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        counter: SizedBox()
      ),
    );
  }
}

class TextToTypeField extends StatelessWidget {
  const TextToTypeField({
    super.key,
    required this.typingController,
  });

  final TypingController typingController;

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