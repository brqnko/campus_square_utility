import 'package:campus_square_app/state/thing_to_bring/provider.dart';
import 'package:campus_square_app/view/dialogs/lecture_detail.dart';
import 'package:campus_square_app/view/theme/fonts.dart';
import 'package:campus_square_app/view/theme/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThingsToBring extends ConsumerWidget {
  const ThingsToBring({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thingsToBring = ref.watch(thingsToBringNotifier);

    if (thingsToBring.hasValue && thingsToBring.value!.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: thingsToBring.value!.length,
        itemBuilder: (context, index) {
          final thingToBring = thingsToBring.value!.elementAt(index);

          return ListTile(
            title: Text(thingToBring.name),
            subtitle: Text(
              thingToBring.lectureName,
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              showLectureDetailDialog(context, thingToBring.lectureName);
            },
          );
        },
      );
    }

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Icon(Icons.shopping_bag_outlined, size: 80),
          Text(
            context.l10n.nothing_bring_today,
            style: AppTextStyle.textB.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
