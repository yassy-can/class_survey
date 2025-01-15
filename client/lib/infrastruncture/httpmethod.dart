import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_end/infrastruncture/dummy.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<List<Map<String, dynamic>>> callGetApi() async {
  const String apiUrl = "http://localhost:8000/items/";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // レスポンスが成功した場合
      //debugPrint("http succes");

      // UTF-8 でデコードして JSON を解析
      debugPrint("response.body:\n ${response.body}");

      final decodedResponse = utf8.decode(response.bodyBytes);
      // debugPrint("decodedResponse:\n ${decodedResponse}");

      final List<dynamic> jsonData = json.decode(decodedResponse);
      // debugPrint("jsonData:\n ${jsonData}");
      // debugPrint("jsonData type ${jsonData.runtimeType}");
      // debugPrint("json type ${jsonData[0].runtimeType}");

      // 各要素を再度デコードして Map<String, dynamic> に変換
      final List<Map<String, dynamic>> result = jsonData
          .map((item) => json.decode(item) as Map<String, dynamic>)
          .toList();

      debugPrint("Decoded result:\n $result");
      return result;
    } else {
      // エラー処理
      debugPrint('Failed to load items: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
  }

  return [];
}

Future<void> uploadFile(Uint8List selectedFile) async {
  try {
    // アップロード先のURL
    const url = 'http://localhost:8000/upload/';

    // HTTPリクエストの設定
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      http.MultipartFile.fromBytes(
        'file', // サーバー側で受け取るときのフィールド名
        selectedFile,
      ),
    );

    // リクエストの送信
    final response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('ファイルが正常にアップロードされました');
    } else {
      debugPrint('ファイルのアップロードに失敗しました: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('エラーが発生しました: $e');
  } finally {
    debugPrint('uploadFile done');
  }
}

Future<Map<dynamic, dynamic>?> uploadCsvFile(Uint8List fileBytes) async {
  const bool isDockerMode =
      false; //String.fromEnvironment('DOCKER_MODE') == 'true';

  if (isDockerMode) {
    // try {
    //   // リクエストのURL
    //   final url = Uri.parse('http://localhost:8000/upload_csv/');

    //   // マルチパートリクエストの作成
    //   var request = http.MultipartRequest('POST', url);

    //   // CSVファイルの追加
    //   request.files.add(
    //     http.MultipartFile.fromBytes(
    //       'file', // サーバー側で使用するフィールド名
    //       fileBytes,
    //       filename: 'upload.csv',
    //       contentType: MediaType('text', 'csv'), // CSVファイルの Content-Type
    //     ),
    //   );

    //   // リクエストの送信
    //   var response = await request.send();

    //   // ステータスコードの確認
    //   if (response.statusCode == 200) {
    //     final responseBody = await response.stream.bytesToString();
    //     debugPrint('ファイルが正常にアップロードされました');
    //     debugPrint("response.body:\n$responseBody");
    //     return responseBody;
    //   } else {
    //     debugPrint("CSVファイルのアップロードに失敗しました: ${response.statusCode}");
    //     return null;
    //   }
    // } catch (e) {
    //   debugPrint("エラーが発生しました: $e");
    // }
  } else {
    await Future.delayed(const Duration(seconds: 1));
    return dummydata['data'];
  }
}
