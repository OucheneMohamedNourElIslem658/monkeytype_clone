import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/typing/screens/record.dart';
import 'package:word_generator/word_generator.dart';

class CustomTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan({required context, style, required withComposing}) {
    final typingController = Get.find<TypingConfigirationBarController>();
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

class TypingConfigirationBarController extends GetxController {

  final typingModeOptions = [
    {
      'name': 'words',
      'isSelected': true,
      'icon': Icons.text_fields
    },
    {
      'name': 'time',
      'isSelected': false,
      'icon': Icons.timer
    }
  ];

  var isWordsSelected = true;

  void selectTypingMode(int index) {
    for (int i = 0; i < typingModeOptions.length; i++) {
      if (i == index) {
        typingModeOptions[i]['isSelected'] = true;
        if (typingModeOptions[i]['name'] == 'words') {
          isWordsSelected = true;
          resetWords();
        }
      } else {
        typingModeOptions[i]['isSelected'] = false;
        if (typingModeOptions[i]['name'] == 'words') {
          isWordsSelected = false;
          resetTime();
        }
        updateCurrentTimePeriod();
        updateCurrentWordsNumber();
      }
    }
    update();
  }

  final wordNumbers = [
    {
      'number' : 10,
      'isSelected': false
    },
    {
      'number' : 25,
      'isSelected': false
    },
    {
      'number' : 50,
      'isSelected': true
    },
    {
      'number' : 100,
      'isSelected': false
    },
  ];

  void chooseWordNumber(int index) {
    for (int i = 0; i < wordNumbers.length; i++) {
      if (i == index) {
        wordNumbers[i]['isSelected'] = true;
      } else {
        wordNumbers[i]['isSelected'] = false;
      }
    }
    updateCurrentWordsNumber();
    generateRandomText(wordsNumber);
    update();
  }

  final timePeriods = [
    {
      'period': 15,
      'isSelected': false
    },
    {
      'period': 30,
      'isSelected': true
    },
    {
      'period': 60,
      'isSelected': false
    },
    {
      'period': 120,
      'isSelected': false
    }
  ];


  void choosePeriod(int index){
    for (int i = 0; i < timePeriods.length; i++) {
      if (i == index) {
        timePeriods[i]['isSelected'] = true;
      } else {
        timePeriods[i]['isSelected'] = false;
      }
    }
    updateCurrentTimePeriod();
    update();
  }

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
  late int wordsNumber;
  late int timePeriod;
  RxInt leftTime = 0.obs;

  void updateCurrentWordsNumber(){
    if (isWordsSelected) {
      for (int i = 0; i < wordNumbers.length; i++) {
        if (wordNumbers[i]['isSelected'] == true) {
          wordsNumber = wordNumbers[i]['number'] as int;
        }
      }
    } else {
      wordsNumber = 1000;
    }
    update();
  }

  void updateCurrentTimePeriod(){
    for (int i = 0; i < timePeriods.length; i++) {
      if (timePeriods[i]['isSelected'] == true) {
        timePeriod = timePeriods[i]['period'] as int;
      }
    }
    update();
  }

  void generateRandomText(int wordsNumber) {
    final wordGenerator = WordGenerator();
    textToType = wordGenerator.randomSentence(wordsNumber);
    textToType = '$textToType\n';
  }

  void focusOnField(){
    typedTextFocusNode.requestFocus();
  }

  void keepTrackWords(String newValue){
    textToTypeScrollController.jumpTo(typedTextScrollController.offset);
    if (newValue.isNotEmpty && !startTyping) {
      startTime = DateTime.now();
      startTyping = true;
    }

    if (newValue.length > 1) {
      if (newValue[newValue.length-1] != textToType[newValue.length-1]) {
        totalMistakes++;
      }
    }
    
    if (newValue.length == textToType.length-2) {
      startTyping = false;
      endTime = DateTime.now();
      for (var i = 0; i < typedText.length; i++) {
        if (typedText[i] == textToType[i]) {
          correctAnswers ++;
        }
      }
      Get.to(const Record()); // Replace this line with the concrete subtype instantiation.
    }

    typedCaractersNumber ++;
    typedText = newValue;
    update();
  }

  void keepTrackTime(String newValue){
    textToTypeScrollController.jumpTo(typedTextScrollController.offset);
    if (newValue.isNotEmpty && !startTyping) {
      startTime = DateTime.now();
      startTyping = true;
    }

    if (newValue.length > 1) {
      if (newValue[newValue.length-1] != textToType[newValue.length-1]) {
        totalMistakes++;
      }
    }
    
    if (newValue.length == textToType.length-2) {
      startTyping = false;
      for (var i = 0; i < typedText.length; i++) {
        if (typedText[i] == textToType[i]) {
          correctAnswers ++;
        }
      }
      goToRecord();
    }

    typedCaractersNumber ++;
    typedText = newValue;
    update();
  }

  void goToRecord() => Get.to(const Record());

  String getTime(){
    return endTime!.difference(startTime!).inSeconds.toString();
  }

  void resetWords(){
    totalMistakes = 0;
    typedCaractersNumber = 0;
    correctAnswers = 0;
    typedText = '';
    startTyping = false;
    generateRandomText(wordsNumber);
    controller = CustomTextEditingController();
    typedTextScrollController.jumpTo(0);
    textToTypeScrollController.jumpTo(0);
    update();
  }

  void resetTime(){
    totalMistakes = 0;
    typedCaractersNumber = 0;
    correctAnswers = 0;
    typedText = '';
    startTyping = false;
    generateRandomText(wordsNumber);
    controller = CustomTextEditingController();
    typedTextScrollController.jumpTo(0);
    textToTypeScrollController.jumpTo(0);
    update();
  }

  
  final key = GlobalKey();
  @override
  void onInit() {
    updateCurrentWordsNumber();
    updateCurrentTimePeriod();
    generateRandomText(wordsNumber);
    typedTextScrollController.addListener(() {
      textToTypeScrollController.jumpTo(typedTextScrollController.offset);
    });
    super.onInit();
  }
        
}