import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/state.dart';

import 'widgets/settings_group.dart';
import 'widgets/settings_item.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, String>(
      converter: (store) => store.state.loginState.user?.email ?? '',
      builder: _build);

  Widget _build(BuildContext context, String email) {
    return SettingsGroup(
      title: 'Account',
      items: [
        SettingsItem(
          title: 'Email',
          subTitle: email,
        ),
      ],
    );
  }
}
