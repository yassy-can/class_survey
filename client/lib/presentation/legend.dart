import 'package:flutter/material.dart';
import 'package:front_end/presentation/theme/colors.dart';

Container legend() {
  return Container(
    // decoration: BoxDecoration(
    //   color: Colors.white, // 背景色
    //   borderRadius: BorderRadius.circular(16), // 角丸
    //   border: Border.all(color: Colors.blue, width: 2), // 縁の色と太さ
    // ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 15,
              height: 15,
              color: chartColors.colors[0],
            ),
            Text('学習意欲が高い'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 15,
              height: 15,
              color: chartColors.colors[1],
            ),
            Text('どちらでもない'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 15,
              height: 15,
              color: chartColors.colors[2],
            ),
            Text('学習意欲が低い'),
          ],
        ),
      ],
    ),
  );
}
