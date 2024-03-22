import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TypingRecord extends HiveObject {
  @HiveField(0)
  List<int> wpms;

  @HiveField(1)
  List<int> numberOfErrors;

  @HiveField(2)
  double accuracy;

  @HiveField(3)
  int givenWords;

  @HiveField(4)
  CharactersRecord charactersRecord;

  @HiveField(5)
  double consistency;

  @HiveField(6)
  DateTime time;

  @HiveField(7)
  String review;

  TypingRecord({
    required this.wpms,
    required this.numberOfErrors,
    required this.accuracy,
    required this.givenWords,
    required this.charactersRecord,
    required this.consistency,
    required this.time,
    required this.review,
  });
}

@HiveType(typeId: 1)
class CharactersRecord extends HiveObject {
  @HiveField(0)
  int correct;

  @HiveField(1)
  int mistakes;

  @HiveField(2)
  int extra;

  CharactersRecord({
    required this.correct,
    required this.mistakes,
    required this.extra,
  });
}
