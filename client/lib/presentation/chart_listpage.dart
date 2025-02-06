import 'package:flutter/material.dart';
import 'package:front_end/domain/sort.dart';
import 'package:front_end/domain/survey.dart';
import 'package:front_end/presentation/chart_fivequestion.dart';
import 'package:front_end/presentation/freetext.dart';
import 'package:front_end/presentation/spacer.dart';
import 'package:front_end/presentation/theme/fonts.dart';

class ChartListpage extends StatelessWidget {
  final Survey survey;

  const ChartListpage({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    debugPrint('ChartListpage build');
    // final chartlist = sortAndChart(survey);

    // final chartlistview = ListView.builder(
    //   itemCount: chartlist.length, // データの長さを指定
    //   itemBuilder: (context, index) {
    //     return chartlist[index];
    //   },
    // );

    // final listviewcontainer = Container(
    //   child: chartlistview,
    // );

    final newlistview = ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
        itemCount: survey.useQuestion.length,
        itemBuilder: (context, index) {
          final element = survey.useQuestion[index];
          if (survey.lmeData['number_col'].contains(element)) {
            final fivequestion = sort5question(survey, element);
            final jsonList = sortjson(fivequestion);
            final chart = chartFiveQuestion(jsonList);

            final column = Column(
              children: [
                Text('質問${survey.csvData[0][element]}',
                    style: BrandText.titleS),
                spacerSmall(),
                chart,
                spacerMedium(),
              ],
            );
            return column;
          } else {
            final freetextMap = sortfreetext(survey, element);
            final freetextlist = freetext(freetextMap);
            final column = Column(
              children: [
                Text('質問${survey.csvData[0][element]}',
                    style: BrandText.titleS),
                freetextlist,
                spacerMedium()
              ],
            );
            return column;
          }
        });

    return newlistview;
  }
}
