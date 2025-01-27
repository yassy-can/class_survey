import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphic/graphic.dart';

Widget chartFiveQuestion(List<Map<String, dynamic>> adjustData) {
  return Chart(
    data: adjustData,
    variables: {
      'index': Variable(
        accessor: (Map map) => map['index'].toString(),
      ),
      'type': Variable(
        accessor: (Map map) => map['type'] as String,
      ),
      'value': Variable(
        accessor: (Map map) => map['value'] as num,
        scale: LinearScale(min: 0, max: 50),
      ),
    },
    marks: [
      IntervalMark(
          position: Varset('index') * Varset('value') / Varset('type'),
          shape: ShapeEncode(value: RectShape(labelPosition: 0.5)),
          color: ColorEncode(variable: 'type', values: Defaults.colors10),
          label: LabelEncode(
            encoder: (tuple) {
              final value = tuple['value'] as num;
              if (value == 0) {
                return Label(
                    '', LabelStyle(textStyle: const TextStyle(fontSize: 0)));
              }
              return Label(
                value.toString(),
                LabelStyle(textStyle: const TextStyle(fontSize: 20)),
              );
            },
          ),
          modifiers: [StackModifier()],
          // 棒グラフの幅
          size: SizeEncode(value: 50))
    ],
    // coord: RectCoord(
    //   horizontalRangeUpdater: Defaults.horizontalRangeEvent,
    // ), //ホイールで縮尺を変えるやつ
    axes: [
      Defaults.horizontalAxis,
      Defaults.verticalAxis,
    ],
    selections: {
      'tap': PointSelection(
        variable: 'index',
      )
    },
    // 凡例を表示するか
    tooltip: TooltipGuide(multiTuples: true),
    crosshair: CrosshairGuide(),
  );
}
