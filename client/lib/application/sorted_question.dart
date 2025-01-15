import 'package:flutter/material.dart';
import 'package:front_end/domain/questiontracker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sorted_question.g.dart';

@Riverpod(keepAlive: true)
class SortedQuestion extends _$SortedQuestion {
  @override
  Map<String, QuestionTracker> build() {
    return {};
  }

  void updateState(Map<String, QuestionTracker> newData) {
    debugPrint("updateState called");
    state = newData;
  }
}
