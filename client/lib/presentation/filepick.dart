import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:file/file.dart';

class Filepick extends HookWidget {
  const Filepick({super.key});

  @override
  Widget build(BuildContext context) {
    final filename = useState("");

    Future<void> _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        filename.value = result.files.first.name;
        debugPrint(filename.value);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  _pickFile();
                },
                child: Text("button")),
          ],
        ),
      ),
    );
  }
}
