import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/features/home/ui/notes_view.dart';
import 'package:mobipad/features/home/ui/widgets/home_app_bar.dart';
import 'package:mobipad/features/home/ui/widgets/home_drawer.dart';
import 'package:mobipad/features/home/ui/widgets/home_speed_dial.dart';
import 'package:mobipad/state.dart';

import '../view_models/home_page_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.scaffoldKey,
    required this.fabAnimation,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AnimationController fabAnimation;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, HomePageViewModel>(
        converter: (store) => HomePageViewModel(context, store),
        onInit: (store) => store.dispatch(NotificationClickListener()),
        builder: _buildView,
      );

  Widget _buildView(BuildContext context, HomePageViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        return await viewModel.willPop(scaffoldKey);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: const HomeAppBar(),
        drawer: const HomeDrawer(),
        floatingActionButton: HomeSpeedDial(
          fabAnimation: fabAnimation,
        ),
        body: const NotesView(),
      ),
    );
  }
}
