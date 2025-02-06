import 'package:flutter/material.dart';
import 'package:front_end/presentation/spacer.dart';
import 'package:front_end/presentation/theme/fonts.dart';

Widget freetext(Map<String, List<String>> data) {
  final column = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var entry in data.entries)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey,
              child: Text(entry.key, style: BrandText.titleS),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var value in entry.value)
                  Container(
                    //padding: const EdgeInsets.all(10),
                    child: Text(value, style: BrandText.bodyM),
                  ),
              ],
            ),
            spacerSmall(),
          ],
        ),
    ],
  );

  final container = Container(
    width: 800,
    padding: const EdgeInsets.all(10),
    child: column,
  );

  return container;
}
