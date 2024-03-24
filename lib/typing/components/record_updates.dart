import 'package:flutter/material.dart';

import '../controllers/typing_configiration_bar.dart';

class RecordUpdates extends StatelessWidget {
  const RecordUpdates({
    super.key,
    required this.typingController,
  });

  final TypingConfigirationBarController typingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${typingController.typedText.split(' ').length-1} / ${typingController.wordsNumber}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700
          )
        ),
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()), 
          builder:(_, snapshot) {
            if (typingController.startTyping) {
              var period = DateTime.now().difference(typingController.startTime!).inSeconds;
              if (period % 3 == 0) {
                if (!typingController.timeSet.contains(period)) {
                  typingController.updateCorrectAnswers();
                  typingController.updateMistakes();
                }
                typingController.timeSet.add(period);
              }
              if (typingController.isWordsSelected) {
                return Row(
                  children: [
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.circle, 
                      color:Color.fromARGB(255, 216, 216, 216), 
                      size: 15
                    ),
                    const SizedBox(width: 15),
                    Text(
                      '$period',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                );
              } else {
                final leftTime = typingController.timePeriod - period;
                if (leftTime <= 0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    typingController.gameOver();
                  });
                }
                return Text(
                  '$leftTime',
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                  ),
                );
              }
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}