import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_generator/word_generator.dart';
import '../screens/record.dart';

class CustomTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan({required context, style, required withComposing}) {
    final typingController = Get.find<TypingController>();
    final textSpanChildren = <TextSpan>[];
    for (int i = 0; i < text.length; i++) {
      TextStyle wordStyle;
      var shouldTypeLetter = typingController.textToType[i];
      if (text[i] == shouldTypeLetter) {
        wordStyle = const TextStyle(
          color: Colors.green,
          fontSize: 30,
        );
      } else {
        wordStyle = TextStyle(
          color: Colors.red, 
          backgroundColor: shouldTypeLetter == ' ' ? Colors.red : null,
          fontSize: 30
        );
      }
      final child = TextSpan(text: shouldTypeLetter, style: wordStyle);
      textSpanChildren.add(child);
    }
    return TextSpan(style: style, children: textSpanChildren);
  }
}

class TypingController extends GetxController {
  var textToType = '';
  var typedText = '';
  var totalMistakes = 0,typedCaractersNumber = 0;
  var correctAnswers = 0;
  var controller = CustomTextEditingController();
  DateTime? startTime,endTime;
  var startTyping = false;
  final typedTextScrollController = ScrollController();
  final textToTypeScrollController = ScrollController();
  final typedTextFocusNode = FocusNode();

  void generateRandomText() {
    final wordGenerator = WordGenerator();
    textToType = wordGenerator.randomSentence(50);
    textToType = '$textToType\n';
  }

  void focusOnField(){
    typedTextFocusNode.requestFocus();
  }

  void keepTrack(String newValue){

    if (newValue.isNotEmpty && !startTyping) {
      startTime = DateTime.now();
      startTyping = true;
    }

    if (newValue[newValue.length-1] != textToType[newValue.length-1]) {
      totalMistakes++;
    }
    
    if (newValue.length == textToType.length-2) {
      startTyping = false;
      endTime = DateTime.now();
      for (var i = 0; i < typedText.length; i++) {
        if (typedText[i] == textToType[i]) {
          correctAnswers ++;
        }
      }
      Get.to(const Record());
    }

    typedCaractersNumber ++;
    typedText = newValue;
    update();
  }

  String getTime(){
    return endTime!.difference(startTime!).inSeconds.toString();
  }

  void reset(){
    totalMistakes = 0;
    typedCaractersNumber = 0;
    correctAnswers = 0;
    typedText = '';
    startTyping = false;
    generateRandomText();
    controller = CustomTextEditingController();
    typedTextScrollController.jumpTo(0);
    textToTypeScrollController.jumpTo(0);
    update();
  }

  @override
  void onInit() {
    generateRandomText();
    typedTextScrollController.addListener(() {
      textToTypeScrollController.jumpTo(typedTextScrollController.position.pixels);
    });
    super.onInit();
  }
}