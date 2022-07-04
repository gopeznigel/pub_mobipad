import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/settings/ui/privacy_page.dart';
import 'package:mobipad/services/package_info_manager.dart';
import 'package:mobipad/state.dart';

import 'widgets/settings_group.dart';
import 'widgets/settings_item.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, String>(
      converter: (store) => store.state.loginState.user?.email ?? '',
      builder: _build);

  Widget _build(BuildContext context, String email) {
    return SettingsGroup(
      title: 'Help',
      items: [
        SettingsItem(
          title: 'About Oh Notes!',
          subTitle: 'App information',
          trail: const Icon(
            Icons.info,
            color: Color(0xFF606060),
            size: 20,
          ),
          onTap: () async {
            final logo = Image.asset(
              'assets/icons/oh-notes_logo.png',
              height: MediaQuery.of(context).size.height * 0.1,
            );

            showAboutDialog(
                context: context,
                applicationIcon: logo,
                applicationName: 'Oh Notes!',
                applicationVersion: PackageInfoManager().fullVersionNumber(),
                applicationLegalese: '©2022 Tap Console');
          },
        ),
        SettingsItem(
          title: 'Official Site',
          subTitle: 'Visit our page',
          trail: const Icon(
            Icons.public,
            color: Color(0xFF606060),
            size: 20,
          ),
          onTap: () {
            Navigator.pushNamed(context, PrivacyPage.route,
                arguments: 'https://oh-notes.flycricket.io/');
          },
        ),
        SettingsItem(
          title: 'Privacy Policy',
          subTitle: 'See app privacy policy',
          trail: const Icon(
            Icons.public,
            color: Color(0xFF606060),
            size: 20,
          ),
          onTap: () {
            Navigator.pushNamed(context, PrivacyPage.route,
                arguments: 'https://oh-notes.flycricket.io/privacy.html');
          },
        ),
      ],
    );
  }
}
