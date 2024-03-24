import 'package:flutter/material.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({
    super.key,
    required this.value,
    required this.title, 
    this.titleSize, 
    this.valueSize
  });

  final String value,title;
  final double? titleSize,valueSize;
  

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              fontSize: titleSize ?? 30,
              color: Colors.grey[300]
            )
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: valueSize ?? 50,
              color: Colors.yellow,
              fontWeight: FontWeight.w600
            )
          )
        ]
      )
    );
  }
}