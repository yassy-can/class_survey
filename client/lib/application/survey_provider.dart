import 'package:front_end/domain/sort.dart';
import 'package:front_end/domain/survey.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'survey_provider.g.dart';

@Riverpod(keepAlive: true)
class Surveynotifier extends _$Surveynotifier {
  @override
  Survey build({required String subjectName}) {
    return providerInit(subjectName);
  }

  Survey providerInit(String subjectName) {
    return Survey(
        subjectName: subjectName, csvData: [], lmeData: {}, useQuestion: []);
  }

  void update_csvData(List<dynamic> newcsvData) {
    state = state.copyWith(csvData: newcsvData);
  }

  void update_lmeData(Map<dynamic, dynamic> newlmeData) {
    state = state.copyWith(lmeData: newlmeData);
  }

  void update_useQuestion(List<int> newuseQuestion) {
    state = state.copyWith(useQuestion: newuseQuestion);
    // sort(state);
  }
}
