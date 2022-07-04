import 'package:flutter/material.dart';
import 'package:mobipad/styles/text_styles.dart';

typedef OnTap = void Function();

class SettingsItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? trail;
  final OnTap? onTap;

  const SettingsItem({
    Key? key,
    required this.title,
    this.onTap,
    this.subTitle,
    this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: OhNotesTextStyles.notePreviewBody.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Visibility(
                    visible: subTitle != null,
                    child: Text(
                      subTitle ?? '',
                      style: OhNotesTextStyles.notePreviewBody.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: trail != null,
                child: trail ?? const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
