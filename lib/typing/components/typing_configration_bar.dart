import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/typing/controllers/typing_configiration_bar.dart';

class TypingConfigirationBar extends StatelessWidget {
  const TypingConfigirationBar({
    super.key, 
    required this.typingController
  });

  final TypingConfigirationBarController typingController;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          color:const Color.fromARGB(255, 108, 108, 108),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GetBuilder<TypingConfigirationBarController>(
          builder: (_) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TypingMode(typingConfigirationBarController: typingController),
                devider(),
                if (typingController.isWordsSelected) 
                  ChooseWordsNumber(typingConfigirationBarController: typingController) 
                else
                  ChooseTimePeriod(typingConfigirationBarController: typingController),
              ],
            );
          }
        ),
      ),
    );
  }

  Container devider() {
    return Container(
      height: 20,
      width: 3,
      color: Colors.white,
    );
  }
}

class TypingMode extends StatelessWidget {
  const TypingMode({
    super.key, 
    required this.typingConfigirationBarController
  });

  final TypingConfigirationBarController typingConfigirationBarController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TypingConfigirationBarController>(
      builder: (_) {
        return Row(
          children: List.generate(
            typingConfigirationBarController.typingModeOptions.length, 
            (index) {
              final typingMode = typingConfigirationBarController.typingModeOptions[index];
              final name = typingMode['name'] as String;
              final isSelected = typingMode['isSelected'] as bool;
              final icon = typingMode['icon'] as IconData;
              return TextButton(
                onPressed: () => typingConfigirationBarController.selectTypingMode(index), 
                child: Row(
                  children: [
                    Icon(
                      icon, 
                      color: isSelected ? Colors.yellow : Colors.white
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: isSelected ? Colors.yellow : Colors.white
                      ),
                    ),
                  ],
                )
              );
            }
          ),
        );
      }
    );
  }
}

class ChooseWordsNumber extends StatelessWidget {
  const ChooseWordsNumber({
    super.key, 
    required this.typingConfigirationBarController
  });

  final TypingConfigirationBarController typingConfigirationBarController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TypingConfigirationBarController>(
      builder: (_) {
        return Row(
          children: List.generate(
            typingConfigirationBarController.wordNumbers.length, 
            (index) {
              final wordsNumber = typingConfigirationBarController.wordNumbers[index];
              final number = wordsNumber['number'] as int;
              final isSelected = wordsNumber['isSelected'] as bool;
              return TextButton(
                onPressed: () => typingConfigirationBarController.chooseWordNumber(index), 
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.yellow : Colors.white
                  ),
                )
              );
            }
          ),
        );
      }
    );
  }
}

class ChooseTimePeriod extends StatelessWidget {
  const ChooseTimePeriod({
    super.key, 
    required this.typingConfigirationBarController
  });

  final TypingConfigirationBarController typingConfigirationBarController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TypingConfigirationBarController>(
      builder: (_) {
        return Row(
          children: List.generate(
            typingConfigirationBarController.timePeriods.length, 
            (index) {
              final timePeriod = typingConfigirationBarController.timePeriods[index];
              final period = timePeriod['period'] as int;
              final isSelected = timePeriod['isSelected'] as bool;
              return TextButton(
                onPressed: () => typingConfigirationBarController.choosePeriod(index), 
                child: Text(
                  period.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.yellow : Colors.white
                  ),
                )
              );
            }
          ),
        );
      }
    );
  }
}