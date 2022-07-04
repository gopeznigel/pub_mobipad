import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/utils/date_time_util.dart';
import 'package:redux/redux.dart';

class NoteDateInfoContainer extends StatelessWidget {
  const NoteDateInfoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _build,
      );

  Widget _build(BuildContext context, NotePageViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: viewModel.status.isEditing
          ? const SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // creation and edited date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          DateTimeUtil.readTimestamp(viewModel.dateCreated,
                              viewModel.selectedDateTimeDisplay),
                          style: OhNotesTextStyles.notePreviewDates.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.slow_motion_video,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          DateTimeUtil.readTimestamp(viewModel.dateModified,
                              viewModel.selectedDateTimeDisplay),
                          style: OhNotesTextStyles.notePreviewDates.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // reminder, next reminder on; if any
                viewModel.withActiveReminder
                    ? Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.grey,
                            size: 15,
                          ),
                          Text(
                            viewModel.nextReminder,
                            style: OhNotesTextStyles.notePreviewDates.copyWith(
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0.5,
                ),
              ],
            ),
    );
  }
}
