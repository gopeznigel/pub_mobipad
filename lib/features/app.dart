import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';

import '../state.dart';
import 'login/actions.dart';

class App extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) => StoreBuilder(
        onInit: (Store<AppState> store) => store.dispatch(CheckLoginStatus()),
        builder: (BuildContext context, Store<AppState> store) =>
            _buildSplash(context),
      );

  Widget _buildSplash(BuildContext context) {
    final _appTitle = Text(
      'Oh Notes!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 100.sp,
        fontWeight: FontWeight.w700,
      ),
    );

    final _logo = Image.asset(
      'assets/icons/oh-notes_logo.png',
      height: MediaQuery.of(context).size.height * 0.5 / 2,
    );

    final _scaffold = Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: Center(child: _logo),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: _appTitle,
            ),
          ],
        ),
      ),
    );

    return _scaffold;
  }
}
