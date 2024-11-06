import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
