import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_end/domain/survey.dart';
import 'package:front_end/infrastruncture/dummy.dart';
import 'package:graphic/graphic.dart';

Container chartFiveQuestion(List<Map<String, dynamic>> adjustData) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    width: 350,
    height: 300,
    child: Chart(
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
          scale: LinearScale(min: 0, max: 1800),
        ),
      },
      marks: [
        IntervalMark(
            position: Varset('index') * Varset('value') / Varset('type'),
            shape: ShapeEncode(value: RectShape(labelPosition: 0.5)),
            color: ColorEncode(variable: 'type', values: Defaults.colors10),
            label: LabelEncode(
                encoder: (tuple) => Label(
                      tuple['value'].toString(),
                      LabelStyle(textStyle: const TextStyle(fontSize: 20)),
                    )),
            modifiers: [StackModifier()],
            size: SizeEncode(value: 20))
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
      tooltip: TooltipGuide(multiTuples: true),
      crosshair: CrosshairGuide(),
    ),
  );
}
