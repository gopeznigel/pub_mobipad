import 'package:flutter/material.dart';
import 'package:mobipad/features/settings/ui/widgets/settings_item.dart';
import 'package:mobipad/styles/text_styles.dart';

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsGroup({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              style: OhNotesTextStyles.reminderTitle.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
          Column(
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  items[i],
                ],
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
