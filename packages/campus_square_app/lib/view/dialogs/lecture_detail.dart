import 'package:campus_square_app/logic/lecture_thing_to_bring/types/lecture_thing_to_bring.dart';
import 'package:campus_square_app/state/lecture_thing_to_bring/provider.dart';
import 'package:campus_square_app/view/theme/colors.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final thingToBringNameProvider = StateProvider<String>((ref) => '');

class LectureDetailDialog extends ConsumerWidget {
  final String lectureName;

  const LectureDetailDialog(this.lectureName, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thingToBringInputField = SizedBox(
      width: 175,
      child: TextField(
        decoration: InputDecoration(
          labelText: context.l10n.things_to_bring,
          focusColor: AppColor.textInputFocusedColor,
        ),
        onChanged: (value) {
          ref.read(thingToBringNameProvider.notifier).state = value;
        },
      ),
    );

    final thingToBringAddButton = ElevatedButton(
      onPressed: () {
        final thingToBringName = ref.read(thingToBringNameProvider);
        if (thingToBringName.isEmpty) {
          return;
        }

        ref.read(lectureThingToBringNotifier.notifier).addLectureThingToBring(
            lectureName,
            LectureThingToBring(
              name: thingToBringName,
            ),
        );
      },
      child: Text(
        context.l10n.add,
        style: AppTextStyle.buttonS.copyWith(color: Colors.blue),
      ),
    );

    final lectureThingToBrings = ref.watch(lectureThingToBringNotifier);
    final lectureThingToBringListView = lectureThingToBrings.when(
      data: (data) {
        final set = data[lectureName] ?? {};
        return Column(
          children: set.map((thingToBring) {
            return ListTile(
              title: Text(thingToBring.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(lectureThingToBringNotifier.notifier)
                      .removeLectureThingToBring(lectureName, thingToBring);
                },
              ),
            );
          }).toList(),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('${context.l10n.error}: $error'),
    );

    return AlertDialog(
      title: Text(
        lectureName,
        style: AppTextStyle.textB.copyWith(color: Colors.black),
      ),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            Row(
              children: [
                thingToBringInputField,
                const SizedBox(width: 16),
                thingToBringAddButton,
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: lectureThingToBringListView,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showLectureDetailDialog(BuildContext context, String lectureName) {
  showDialog(
    context: context,
    builder: (context) {
      return LectureDetailDialog(lectureName);
    },
  );
}
