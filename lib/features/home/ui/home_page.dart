import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'home_view.dart';

class HomePage extends StatefulWidget {
  static const String route = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  AnimationController? _fabAnimation;

  @override
  void initState() {
    super.initState();

    _fabAnimation = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    _fabAnimation?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0) {
          if (notification is UserScrollNotification) {
            final userScroll = notification;
            switch (userScroll.direction) {
              case ScrollDirection.forward:
                if (userScroll.metrics.maxScrollExtent !=
                    userScroll.metrics.minScrollExtent) {
                  _fabAnimation!.forward();
                }
                break;
              case ScrollDirection.reverse:
                if (userScroll.metrics.maxScrollExtent !=
                    userScroll.metrics.minScrollExtent) {
                  _fabAnimation!.reverse();
                }
                break;
              case ScrollDirection.idle:
                break;
            }
          }
        }
        return false;
      },
      child: HomeView(
        scaffoldKey: _globalKey,
        fabAnimation: _fabAnimation!,
      ),
    );
  }
}
