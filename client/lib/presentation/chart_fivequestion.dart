import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/presentation/legend.dart';
import 'package:front_end/presentation/theme/colors.dart';
import 'package:graphic/graphic.dart';

Widget chartFiveQuestion(List<Map<String, dynamic>> adjustData) {
  final chart = Chart(
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
        scale: LinearScale(min: 0, max: 40),
      ),
    },
    marks: [
      IntervalMark(
          position: Varset('index') * Varset('value') / Varset('type'),
          shape: ShapeEncode(value: RectShape(labelPosition: 0.5)),
          color: ColorEncode(variable: 'type', values: chartColors.colors),
          label: LabelEncode(
            encoder: (tuple) {
              final value = tuple['value'] as num;
              if (value == 0) {
                return Label(
                    '', LabelStyle(textStyle: const TextStyle(fontSize: 0)));
              }
              if (value > 3) {
                return Label(
                  value.toString(),
                  LabelStyle(textStyle: const TextStyle(fontSize: 20)),
                );
              } else {
                return Label('');
              }
            },
          ),
          modifiers: [StackModifier()],
          // 棒グラフの幅
          size: SizeEncode(value: 40))
    ],
    coord: RectCoord(transposed: true),
    // coord: RectCoord(
    //   horizontalRangeUpdater: Defaults.horizontalRangeEvent,
    // ), //ホイールで縮尺を変えるやつ
    axes: [
      AxisGuide(
        grid: PaintStyle(strokeColor: Colors.grey, strokeWidth: 0.5),
        dim: Dim.y,
        label: LabelStyle(
          textStyle: const TextStyle(fontSize: 20),
        ),
      ),
      AxisGuide(
        grid: PaintStyle(strokeColor: Colors.grey, strokeWidth: 0.5),
        dim: Dim.x,
        label: LabelStyle(
            textStyle: const TextStyle(fontSize: 20), offset: Offset(-5, 0)),
      )
    ],
    selections: {
      'tap': PointSelection(
        variable: 'index',
      )
    },
    // 凡例を表示するか
    tooltip: TooltipGuide(constrained: true),
    crosshair: CrosshairGuide(),
  );

  return Container(
      width: 500,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white, // 背景色
        // borderRadius: BorderRadius.circular(16), // 角丸
        // border: Border.all(color: Colors.blue, width: 2), // 縁の色と太さ
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: chart,
          ),
          legend()
        ],
      ));
}
