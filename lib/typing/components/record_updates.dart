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
          '${typingController.typedText.split(' ').length-1} / ${typingController.wordsNumber}'
        ),
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()), 
          builder:(_, snapshot) {
            if (typingController.startTyping) {
              var period = DateTime.now().difference(typingController.startTime!).inSeconds;
              if (typingController.isWordsSelected) {
                return Text(' | $period');
              } else {
                final leftTime = typingController.timePeriod - period;
                if (leftTime <= 0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    typingController.goToRecord();
                  });
                }
                return Text(' | $leftTime');
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