import 'package:flutter/material.dart';
import 'package:mobipad/features/settings/ui/about_view.dart';
import 'package:mobipad/features/settings/ui/account_view.dart';
import 'package:mobipad/features/settings/ui/general_settings_view.dart';

class SettingsPage extends StatelessWidget {
  static const String route = '/settingsPage';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AccountView(),
            GeneralSettingsView(),
            AboutView(),
          ],
        ),
      ),
    );
  }
}
