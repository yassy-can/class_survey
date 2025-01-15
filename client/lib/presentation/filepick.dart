import 'package:flutter/material.dart';
import 'package:front_end/domain/filepick.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Filepick extends HookConsumerWidget {
  const Filepick({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            handleFileSelection(context, ref);
          },
          child: const Text("chose file")),
    );
  }
}
