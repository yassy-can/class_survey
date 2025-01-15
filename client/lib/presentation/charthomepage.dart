import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front_end/application/survey_provider.dart';
import 'package:front_end/domain/sort.dart';
import 'package:front_end/presentation/chart_listpage.dart';
import 'package:front_end/presentation/selectquestion.dart';
import 'package:front_end/presentation/subjectdrawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChartHomepage extends HookConsumerWidget {
  final List<String> subjectlist;

  const ChartHomepage({
    super.key,
    required this.subjectlist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectIdx = useState(0);

    final subjectName = subjectlist[subjectIdx.value];
    final survey = ref.watch(surveynotifierProvider(subjectName: subjectName));
    //final surveynotifier = ref.read(surveynotifierProvider(subjectName: subjectName).notifier);
    final useQuestion = survey.useQuestion;

    // ボタンにより質問選択画面に遷移
    onPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Selectquestion(
                  subjectName: subjectName,
                  isFirst: false,
                )),
      );
    }

    final subjectDrawer = SubjectDrawer(
      subjectList: subjectlist,
      selectedIndex: subjectIdx.value,
      ref: ref,
      onSelect: (newidx) {
        subjectIdx.value = newidx;
      },
    );

    // 質問が選択されていない場合は質問選択画面を表示
    if (useQuestion.isEmpty) {
      // return Text('selectquestion');
      return Selectquestion(
        subjectName: subjectName,
        isFirst: true,
      );
      // 質問が選択されている場合はグラフを表示
    } else {
      // 質問をソートして、グラフを表示
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("chartpage"),
          ),
          body: Text('test'), //ChartListpage(survey: survey),
          floatingActionButton: FloatingActionButton(onPressed: onPressed()),
          drawer: subjectDrawer);
    }
  }
}
