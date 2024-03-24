class History {
    final int wpm;
    final int acc;
    final int consistency;
    final int takenTime;
    final String review;
    final String comparision;
    final String testType;
    final List<int> correctAnsswersEverySecond;
    final List<int> mistakesEverySecond;
    final DateTime when;
    final int extraCaracter;
    final int correctCaracters;
    final int mistakes;

    History({
        required this.wpm,
        required this.acc,
        required this.consistency,
        required this.takenTime,
        required this.review,
        required this.comparision,
        required this.testType,
        required this.correctAnsswersEverySecond,
        required this.mistakesEverySecond,
        required this.when,
        required this.extraCaracter,
        required this.correctCaracters,
        required this.mistakes,
    });

    factory History.fromMap(Map<String, dynamic> json) => History(
        wpm: json["wpm"],
        acc: json["acc"],
        consistency: json["consistency"],
        takenTime: json["takenTime"],
        review: json["review"],
        comparision: json["comparision"],
        testType: json["testType"],
        correctAnsswersEverySecond: List<int>.from(json["correctAnsswersEverySecond"].map((x) => x)),
        mistakesEverySecond: List<int>.from(json["mistakesEverySecond"].map((x) => x)),
        when: DateTime.parse(json["when"]),
        extraCaracter: json["extraCaracter"],
        correctCaracters: json["correctCaracters"],
        mistakes: json["mistakes"],
    );

    Map<String, dynamic> toMap() => {
        "wpm": wpm,
        "acc": acc,
        "consistency": consistency,
        "takenTime": takenTime,
        "review": review,
        "comparision": comparision,
        "testType": testType,
        "correctAnsswersEverySecond": List<dynamic>.from(correctAnsswersEverySecond.map((x) => x)),
        "mistakesEverySecond": List<dynamic>.from(mistakesEverySecond.map((x) => x)),
        "when": when.toIso8601String(),
        "extraCaracter": extraCaracter,
        "correctCaracters": correctCaracters,
        "mistakes": mistakes,
    };
}
