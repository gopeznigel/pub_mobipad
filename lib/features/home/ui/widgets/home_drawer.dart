import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/dialogs/dialogs.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/home/actions.dart';
import 'package:mobipad/features/home/view_models/home_page_view_model.dart';
import 'package:mobipad/features/login/actions.dart';
import 'package:mobipad/features/settings/ui/settings_page.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:redux/redux.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return StoreConnector(
        converter: (Store<AppState> store) => HomePageViewModel(context, store),
        builder: (BuildContext context, HomePageViewModel viewModel) {
          return Drawer(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Home',
                          style: OhNotesTextStyles.drawerOptions.copyWith(
                            color: !viewModel.homeViewMode.isArchived &&
                                    !viewModel.homeViewMode.isTrashed
                                ? Colors.cyan
                                : Colors.black,
                          ),
                        ),
                        leading: Icon(Icons.home,
                            color: !viewModel.homeViewMode.isArchived &&
                                    !viewModel.homeViewMode.isTrashed
                                ? Colors.cyan
                                : const Color(0xFF888888)),
                        onTap: () {
                          store.dispatch(const SetHomeViewMode(
                              mode: NoteCategoryEnum.active));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Archive',
                          style: OhNotesTextStyles.drawerOptions.copyWith(
                            color: viewModel.homeViewMode.isArchived
                                ? Colors.cyan
                                : Colors.black,
                          ),
                        ),
                        leading: Icon(Icons.archive,
                            color: viewModel.homeViewMode.isArchived
                                ? Colors.cyan
                                : const Color(0xFF888888)),
                        onTap: () {
                          store.dispatch(const SetHomeViewMode(
                              mode: NoteCategoryEnum.archived));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Trash',
                          style: OhNotesTextStyles.drawerOptions.copyWith(
                            color: viewModel.homeViewMode.isTrashed
                                ? Colors.cyan
                                : Colors.black,
                          ),
                        ),
                        leading: Icon(Icons.delete,
                            color: viewModel.homeViewMode.isTrashed
                                ? Colors.cyan
                                : const Color(0xFF888888)),
                        onTap: () {
                          store.dispatch(const SetHomeViewMode(
                              mode: NoteCategoryEnum.trashed));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Settings',
                          style: OhNotesTextStyles.drawerOptions.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        leading: const Icon(Icons.settings,
                            color: Color(0xFF888888)),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.pushNamed(context, SettingsPage.route);
                        },
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Logout',
                        style: OhNotesTextStyles.drawerOptions.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: const Icon(
                        Icons.exit_to_app,
                        color: Color(0xFF888888),
                      ),
                      onTap: () async {
                        var logout = await showConfirmationDialog(context,
                            'Are you sure you want to logout?', 'Logout');

                        if (logout) {
                          store.dispatch(Logout());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
