import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:redux/redux.dart';

import '../state.dart';
import 'login/actions.dart';

class App extends StatelessWidget {
  static const String route = '/';

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreBuilder(
        onInit: (Store<AppState> store) => store
          ..dispatch(CheckLoginStatus())
          ..dispatch(GetFontSize())
          ..dispatch(GetDateTimeDisplay())
          ..dispatch(GetSort()),
        builder: (BuildContext context, Store<AppState> store) =>
            _buildSplash(context),
      );

  Widget _buildSplash(BuildContext context) {
    final appTitle = Text(
      'Oh Notes!',
      textAlign: TextAlign.center,
      style: OhNotesTextStyles.splash.copyWith(
        color: OhNotesColor.primary,
      ),
    );

    final logo = Image.asset(
      'assets/icons/oh-notes_logo.png',
      height: MediaQuery.of(context).size.height * 0.5 / 2,
    );

    final scaffold = Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Center(child: logo),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: appTitle,
            ),
          ],
        ),
      ),
    );

    return scaffold;
  }
}
