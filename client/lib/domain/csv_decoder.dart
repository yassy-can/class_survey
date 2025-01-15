import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

void csvDecoder(String path) async {
  final file = File(path);
  final bytes = await file.readAsBytes();
  final content = utf8.decode(bytes); // エンコーディングに注意
  debugPrint(content); // CSVの中身を確認
}
