class QuestionTracker {
  static const List<String> types = ["学習意欲が低い", "どちらでもない", "学習意欲が高い"];

  final String type;
  final Map<int, int> counts;

  QuestionTracker(this.type) : counts = {for (int i = 1; i <= 5; i++) i: 0};

  // 指定されたインデックスの値をインクリメント
  void increment(int index) {
    if (counts.containsKey(index)) {
      counts[index] = counts[index]! + 1;
    }
  }

  @override
  String toString() {
    return '$counts';
  }
}
