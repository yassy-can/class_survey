import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/application/survey_provider.dart';
import 'package:front_end/application/subject_provider.dart';
import 'package:front_end/infrastruncture/httpmethod.dart';
import 'package:front_end/presentation/subjectdialog.dart';

Future<void> handleFileSelection(BuildContext context, WidgetRef ref) async {
  final PlatformFile? file = await pickFile(); // ファイル選択
  if (file != null) {
    final String? subjectName =
        await subjectDialog(context, file.name); // ダイアログでファイル名を取得
    if (subjectName != null) {
      // ファイル名が変更された場合の処理
      debugPrint('新しいファイル名: $subjectName');
      fileExecute(file, subjectName, ref); // ファイル処理
    }
  } else {
    // ファイルが選択されていない場合の処理
    debugPrint('ファイルが選択されていません');
  }
}

Future<PlatformFile?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
  if (result != null) {
    debugPrint(result.files.first.name);
    return result.files.first;
    // fileState.value?.bytes;
    // print(fileState.value?.bytes);
    // final PlatformFile selectedFile = result.files.first.byte;
    // await uploadCsvFile(selectedFile);
    // debugPrint(selectedFile.);
  } else {
    return null;
  }
}

Future<void> fileExecute(
    PlatformFile selectedFile, String subjectName, WidgetRef ref) async {
  final Uint8List? fileBytes = selectedFile.bytes;

  if (fileBytes != null) {
    final String csvContent = utf8.decode(fileBytes);
    final List<dynamic> csvtolist =
        const CsvToListConverter().convert(csvContent);
    debugPrint('csvContent: ${csvtolist[0]}');
    final Map<dynamic, dynamic>? response = await uploadCsvFile(fileBytes);
    debugPrint('response: ${response}');

    if (response != null) {
      debugPrint('save');
      final surveylistnotifier =
          ref.read(surveynotifierProvider(subjectName: subjectName).notifier);
      surveylistnotifier.update_csvData(csvtolist);
      surveylistnotifier.update_lmeData(response);

      final survey = ref.read(surveynotifierProvider(subjectName: subjectName));
      debugPrint('survey: ${survey.subjectName}');
      final subjectlistnotifier = ref.read(subjectnotifierProvider.notifier);
      subjectlistnotifier.updateState(subjectName);
    }
  }
}
