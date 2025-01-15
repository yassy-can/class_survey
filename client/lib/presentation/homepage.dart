import 'package:flutter/material.dart';
import 'package:front_end/application/subject_provider.dart';
import 'package:front_end/presentation/charthomepage.dart';
import 'package:front_end/presentation/filepick.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectlist = ref.watch(subjectnotifierProvider);
    debugPrint('subjectlist: ${subjectlist}');
    // final soucelistnotifier = ref.read(subjectnotifierProvider.notifier);

    if (subjectlist.isEmpty) {
      return const Filepick(); // subjectlist が空なら Filepick を表示
    } else {
      return ChartHomepage(
        subjectlist: subjectlist,
      );
    }
  }
}
