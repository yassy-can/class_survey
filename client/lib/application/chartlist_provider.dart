import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chartlist_provider.g.dart';

@riverpod
class ChartListnotifier extends _$ChartListnotifier {
  @override
  List<Widget> build() {
    return [];
  }

  void updateState(List<Widget> widgetlist) {
    debugPrint("updateState called");
    state = widgetlist;
  }

  void deleteState() {
    debugPrint("deleteState called");
    state = [];
  }
}
