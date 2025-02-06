import 'package:flutter/material.dart';
import 'package:front_end/domain/questiontracker.dart';
import 'package:front_end/domain/survey.dart';
import 'package:front_end/presentation/chart_fivequestion.dart';

// List<Widget> sortAndChart(Survey survey) {
//   final List<Widget> widgets = [];

//   debugPrint('sort called');
//   final numberCol = survey.lmeData['number_col'];
//   debugPrint('numberCol: $numberCol');
//   debugPrint('useQuestion: ${survey.useQuestion}');

//   for (int element in survey.useQuestion) {
//     if (numberCol.contains(element)) {
//       // 同じ要素が見つかった場合の処理
//       print("Element $element is present in both lists.");
//       final fivequestion = sort5question(survey, element);
//       final jsonList = sortjson(fivequestion);
//       final chart = chartFiveQuestion(jsonList);
//       final column = Column(
//         children: [
//           Text('質問${survey.csvData[0][element]}'),
//           SizedBox(
//             width: 300,
//             height: 300,
//             child: chart,
//           ),
//           const SizedBox(
//             height: 80,
//           ),
//         ],
//       );
//       widgets.add(column);
//     } else {
//       // 同じ要素が見つからなかった場合の処理
//       print("Element $element is not in the second list.");
//       widgets.add(Text('自由記述'));
//     }
//   }

//   return widgets;
// }

Map<String, QuestionTracker> sort5question(Survey survey, int col) {
  debugPrint('sort5question called');

  final List<QuestionTracker> fiveQuestions = [
    for (var type in QuestionTracker.types) QuestionTracker(type),
  ];

  final Map<String, QuestionTracker> questionMap = {
    for (var question in fiveQuestions) question.type: question,
  };

  final int stID_col = survey.lmeData['stID_col'];
  // debugPrint('stID_col: ${stID_col}');
  final Map<int, String> lmeData = survey.lmeData['lmeData'];
  // debugPrint('lmeData: ${lmeData}');
  final csvData = survey.csvData;
  // debugPrint('csvData: ${csvData}');

  for (var entry in lmeData.entries) {
    debugPrint('key: ${entry.key}, value: ${entry.value}');
    // debugPrint(csvData[entry.key][col]);

    // String を int に変換
    final dynamic cellValue = csvData[entry.key][col];

    final value =
        (cellValue is int) ? cellValue : int.parse(cellValue.toString());
    questionMap[entry.value]?.increment(value);
  }

  // debugPrint('questionMap: ${questionMap}');
  return questionMap;
}

List<Map<String, dynamic>> sortjson(Map<String, QuestionTracker> questionMap) {
  debugPrint('sortjson called');
  final index = [1, 2, 3, 4, 5];

  final List<Map<String, dynamic>> jsonList = [];

  for (var entry in questionMap.entries) {
    for (var i in index) {
      jsonList.add({
        "type": entry.key,
        "index": i,
        "value": entry.value.counts[i],
      });
    }
  }

  debugPrint('jsonList: ${jsonList}');

  return jsonList;
}

Map<String, List<String>> sortfreetext(Survey survey, int col) {
  debugPrint('sortfreetext called');

  final Map<String, List<String>> freetextMap = {
    '学習意欲が高い': [],
    'どちらでもない': [],
    '学習意欲が低い': [],
  };

  // final int stID_col = survey.lmeData['stID_col'];
  // debugPrint('stID_col: ${stID_col}');
  final Map<int, String> lmeData = survey.lmeData['lmeData'];
  // debugPrint('lmeData: ${lmeData}');
  final csvData = survey.csvData;
  // debugPrint('csvData: ${csvData}');

  for (var entry in lmeData.entries) {
    final freetext = csvData[entry.key][col];
    debugPrint('lmeData: ${entry.value}, freetext: ${freetext}');
    // debugPrint('freetext: ${freetext}');
    if (freetext.isNotEmpty) {
      freetextMap[entry.value]?.add(freetext);
    }
  }
  // debugPrint('freetextMap: ${freetextMap}');
  return freetextMap;
}
