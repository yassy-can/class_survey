import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/application/chartlist_provider.dart';
import 'package:front_end/presentation/filepick.dart';

class Chartpage extends ConsumerWidget {
  const Chartpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartListInstance = ref.watch(chartListnotifierProvider);
    final chartListnotifier = ref.read(chartListnotifierProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("chartpage"),
        ),
        body: chartListInstance.isEmpty
            ? const Filepick()
            : ListView.builder(
                itemCount: chartListInstance.length, // データの長さを指定
                itemBuilder: (context, index) {
                  final item = chartListInstance[index];
                  return item;
                },
              ),
        floatingActionButton:
            FloatingActionButton(onPressed: chartListnotifier.deleteState));
  }
}
