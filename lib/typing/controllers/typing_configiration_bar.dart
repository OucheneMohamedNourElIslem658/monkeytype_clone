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
  var controller = CustomTextEditingController();
  DateTime? startTime,endTime;
  var startTyping = false;
  final typedTextScrollController = ScrollController();
  final textToTypeScrollController = ScrollController();
  final typedTextFocusNode = FocusNode();
  late int wordsNumber;
  late int timePeriod;
  RxInt leftTime = 0.obs;

  var totalMistakes = 0,typedCaractersNumber = 0,finalMistakes = 0;
  var correctAnswers = 0,totalCorrectAnswers = 0;
  int wpm = 0,accuracy = 0,consistency = 0,raw = 0;
  final correctAnsswersEverySecond = <int>[];
  final mistakesEverySecond = <int>[];

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
    resetWords();
    update();
  }

  void updateCurrentTimePeriod(){
    for (int i = 0; i < timePeriods.length; i++) {
      if (timePeriods[i]['isSelected'] == true) {
        timePeriod = timePeriods[i]['period'] as int;
      }
    }
    resetTime();
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
    updateRealTimeStatistics(newValue);
    if (newValue.length == textToType.length-2) {
      gameOver();
    } else {
      typedCaractersNumber ++;
      typedText = newValue;
      update();
    }
  }

  void keepTrackTime(String newValue){
    updateRealTimeStatistics(newValue);
    if (newValue.length == textToType.length-2) {
      gameOver();
    } else {
      typedCaractersNumber ++;
      typedText = newValue;
      update();
    }
  }

  void goToRecord() {
    final int timeDifference;
    if (isWordsSelected) {
      timeDifference  = endTime!.difference(startTime!).inSeconds;
    } else {
      timeDifference = timePeriod;
    }
    Get.to(
      Record(
        wpm: wpm, 
        acc: accuracy, 
        consistency: consistency, 
        takenTime: timeDifference, 
        review: getReview(), 
        comparision: compareToOther(), 
        testType: testType(), 
        correctAnsswersEverySecond: correctAnsswersEverySecond, 
        mistakesEverySecond: mistakesEverySecond, 
        when: endTime ?? DateTime.now(),
        correctCaracters: correctAnswers,
        mistakes: finalMistakes,
        extraCaracter: getExtraCaracters
      ),
    );
    resetWords();
    resetTime();
  }

  int get getExtraCaracters => typedCaractersNumber - textToType.length-2 < 0 ? 0 : typedCaractersNumber - textToType.length-2;

  final Set<int> timeSet = {};

  void resetWords(){
    totalMistakes = 0;
    typedCaractersNumber = 0;
    correctAnswers = 0;
    typedText = '';
    startTyping = false;
    generateRandomText(wordsNumber);
    controller = CustomTextEditingController();
    timeSet.clear();
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
    timeSet.clear();
    update();
  }

  void updateRealTimeStatistics(String newValue){
    textToTypeScrollController.jumpTo(typedTextScrollController.offset);
    if (newValue.isNotEmpty && !startTyping) {
      startTime = DateTime.now();
      startTyping = true;
    }

    if (newValue.length > 1) {
      if (newValue[newValue.length-1] != textToType[newValue.length-1]) {
        totalMistakes++;
      } else {
        totalCorrectAnswers++;
      }
    }
  }

  void gameOver(){
    startTyping = false;
    endTime = DateTime.now();
    for (var i = 0; i < typedText.length; i++) {
      if (typedText[i] == textToType[i]) {
        correctAnswers ++;
      } else {
        finalMistakes ++;
      }
    }
    calculateStatistics();
    goToRecord();
  }

  void calculateWPM(){
    final timeDifference = endTime!.difference(startTime!);
    final seconds = timeDifference.inSeconds;
    final minutes = seconds / 60;
    wpm = (correctAnswers / 5 / minutes).round();
  }

  void calculateAccuracy(){
    if (typedCaractersNumber != 0) {
      accuracy = ((correctAnswers / typedCaractersNumber) * 100).round();
    } else {
      accuracy = 0;
    }
  }

  void calculateConsistency(){
    consistency = (wpm * accuracy / 100).round();
  }

  String getReview(){
    if (wpm > 80 && accuracy > 90) {
      return 'Excellent typing speed and accuracy. Keep it up!';
    } else if (wpm > 60 && accuracy > 80) {
      return 'Good job, but there is still room for improvement.';
    } else if (wpm > 40 && accuracy > 70) {
      return 'You are getting there. Keep practicing.';
    } else {
      return 'You need more practice. Keep trying.';
    }
  }

  String compareToOther(){
    if (wpm > 80 && accuracy > 90) {
      return 'You are faster and more accurate than 90% of typists.';
    } else if (wpm > 60 && accuracy > 80) {
      return 'You are faster and more accurate than 70% of typists.';
    } else if (wpm > 40 && accuracy > 70) {
      return 'You are faster and more accurate than 50% of typists.';
    } else {
      return 'You are slower and less accurate than 50% of typists.';
    }
  }

  void updateCorrectAnswers(){
    if (correctAnsswersEverySecond.length <= 1) {
      correctAnsswersEverySecond.add(totalCorrectAnswers);
    } else {
      correctAnsswersEverySecond.add(totalCorrectAnswers - correctAnsswersEverySecond.last);
    }
  }

  void updateMistakes(){
    if (mistakesEverySecond.length <= 1) {
      mistakesEverySecond.add(totalMistakes);
    } else {
      mistakesEverySecond.add(totalMistakes - mistakesEverySecond.last);
    }
  }

  void calculateStatistics(){
    calculateAccuracy();
    calculateWPM();
    calculateConsistency();
  }

  String testType(){
    if (isWordsSelected) {
      return 'Words $wordsNumber';
    } else {
      return 'Time $timePeriod';
    }
  }

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