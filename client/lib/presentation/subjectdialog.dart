// ファイル名を修正するダイアログを表示する関数
import 'package:flutter/material.dart';

Future<String?> subjectDialog(BuildContext context, String fileName) async {
  final TextEditingController controller =
      TextEditingController(text: fileName);

  // ファイル名修正ダイアログの表示
  final String? subjectName = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('ファイル名を修正'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '新しいファイル名'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // ダイアログを閉じて、fileStateのファイル名を更新

              Navigator.of(context).pop(controller.text);
            },
            child: const Text('保存'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text('キャンセル'),
          ),
        ],
      );
    },
  );
  return subjectName;
}
