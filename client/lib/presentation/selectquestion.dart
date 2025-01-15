import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front_end/application/survey_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Selectquestion extends HookConsumerWidget {
  final String subjectName;
  final bool isFirst;

  const Selectquestion(
      {super.key, required this.subjectName, required this.isFirst});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final survey = ref.watch(surveynotifierProvider(subjectName: subjectName));
    final useQuestion = survey.useQuestion;
    final questionlist = survey.csvData[0];

    final surveynotifier =
        ref.read(surveynotifierProvider(subjectName: subjectName).notifier);
    final selectIndex = useState(
      useQuestion.isEmpty ? <int>[] : useQuestion,
    );

    Widget listview = ListView.builder(
      itemCount: questionlist.length, // データの長さを指定
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(questionlist[index]),
          value: selectIndex.value.contains(index),
          onChanged: (bool? value) {
            final newSelectIndex = [...selectIndex.value];
            if (value == true) {
              // インデックスを追加
              if (!newSelectIndex.contains(index)) {
                newSelectIndex.add(index);
              }
            } else {
              // インデックスを削除
              newSelectIndex.remove(index);
            }
            selectIndex.value = newSelectIndex;
          },
        );
      },
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("select question"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 横方向の整列
          children: [
            // ListViewはExpandedでラップして、スペースを取るようにする
            Expanded(
              child: listview,
            ),
            // Rowを追加
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 水平方向に中央寄せ
              children: [
                ElevatedButton(
                  onPressed: () {
                    surveynotifier.update_useQuestion(selectIndex.value);

                    // 質問事項を並び替え
                    // sort(survey);

                    if (!isFirst) {
                      Navigator.pop(context);
                    }
                  }, //apply(surveynotifier, selectIndex.value),
                  child: Text('適用'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (!isFirst) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('キャンセル'),
                ),
              ],
            ),
          ],
        ));
  }
}
