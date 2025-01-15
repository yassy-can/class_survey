import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'subject_provider.g.dart';

@Riverpod(keepAlive: true)
class Subjectnotifier extends _$Subjectnotifier {
  @override
  List<String> build() {
    return [];
  }

  void updateState(String newData) {
    debugPrint("updateState called");
    state = [...state, newData];
  }

  void deleteState(String target) {
    debugPrint("removeSubject called");
    // 指定された要素を除外した新しいリストを作成
    state = state.where((item) => item != target).toList();
  }
}
