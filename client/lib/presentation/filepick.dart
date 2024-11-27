import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/application/chartlist_provider.dart';
import 'package:front_end/infrastruncture/httpmethod.dart';

class Filepick extends ConsumerWidget {
  const Filepick({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChartListnotifier = ref.read(chartListnotifierProvider.notifier);

    Future<void> pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        debugPrint(result.files.first.name);
        ChartListnotifier.updateState([Text('data'), Text("data")]);
        final Uint8List? selectedFile = result.files.first.bytes;
        if (selectedFile != null) {
          await uploadCsvFile(selectedFile);
        }
      }
    }

    return Center(
      child: ElevatedButton(
          onPressed: () async {
            pickFile();
          },
          child: Text("chose file")),
    );
  }
}
