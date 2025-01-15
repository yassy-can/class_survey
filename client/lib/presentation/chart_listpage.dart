import 'package:flutter/material.dart';
import 'package:front_end/domain/sort.dart';
import 'package:front_end/domain/survey.dart';

class ChartListpage extends StatelessWidget {
  final Survey survey;

  const ChartListpage({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    debugPrint('ChartListpage build');
    final chartlist = sortAndChart(survey);

    final chartlistview = ListView.builder(
      itemCount: chartlist.length, // データの長さを指定
      itemBuilder: (context, index) {
        return chartlist[index];
      },
    );
    return Text("test"); // chartlistview;
  }
}
