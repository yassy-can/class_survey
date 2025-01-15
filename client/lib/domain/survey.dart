class Survey {
  String subjectName;
  List<dynamic> csvData;
  Map<dynamic, dynamic> lmeData;
  List<int> useQuestion;

  // コンストラクタ
  Survey({
    required this.subjectName,
    required this.csvData,
    required this.lmeData,
    required this.useQuestion,
  });

  Survey copyWith({
    String? subjectName,
    List<dynamic>? csvData,
    Map<dynamic, dynamic>? lmeData,
    List<int>? useQuestion,
  }) {
    return Survey(
      subjectName: subjectName ?? this.subjectName,
      csvData: csvData ?? this.csvData,
      lmeData: lmeData ?? this.lmeData,
      useQuestion: useQuestion ?? this.useQuestion,
    );
  }
}
