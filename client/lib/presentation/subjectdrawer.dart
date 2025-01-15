import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/domain/filepick.dart';

class SubjectDrawer extends StatelessWidget {
  final List<String> subjectList; // メニュー項目
  final int selectedIndex; // 選択されているメニューのインデックス
  final ValueChanged<int> onSelect;
  final WidgetRef ref;

  const SubjectDrawer(
      {super.key,
      required this.subjectList,
      required this.selectedIndex,
      required this.onSelect,
      required this.ref});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'メニューヘッダー',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: subjectList.asMap().entries.map((entry) {
                int idx = entry.key;
                String title = entry.value;
                return ListTile(
                  leading:
                      Icon(idx == selectedIndex ? Icons.check : Icons.circle),
                  title: Text(title),
                  selected: idx == selectedIndex,
                  onTap: () {
                    onSelect(idx); // 選択されたインデックスを親に渡す
                    Navigator.pop(context); // Drawer を閉じる
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                handleFileSelection(context, ref);
              },
              child: const Text('ボタン'),
            ),
          ),
        ],
      ),
    );
  }
}
