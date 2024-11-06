import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front_end/infrastruncture/httpmethod.dart';

class Mylist extends HookWidget {
  const Mylist({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useState<List<Map<String, dynamic>>>([]);

    void addData() async {
      // final newItem = {
      //   "id": data.value.length + 1,
      //   "name": "Item ${data.value.length + 1}"
      // };
      // data.value = [...data.value, newItem]; // 新しいアイテムを追加

      try {
        // APIからデータを取得
        List<Map<String, dynamic>> newData = await callGetApi();

        // 取得したデータをリストに追加
        debugPrint("receve newData: ${newData}");

        data.value = [...data.value, ...newData]; // newDataの要素を展開して追加
      } catch (e) {
        // エラー処理
        debugPrint("Error occurred while adding data: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("mylist"),
      ),
      body: ListView.builder(
        itemCount: data.value.length, // データの長さを指定
        itemBuilder: (context, index) {
          final item = data.value[index];
          return ListTile(
            title: Text(item['name']), // JSONからのデータを表示
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: addData),
    );
  }
}
