import 'package:flutter/material.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/home/ui/home_page.dart';
import 'package:mobipad/services/stream_subscription.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'api.dart';
import 'ui/login_page.dart';

List<Middleware<AppState>> getMiddleware(
        GlobalKey<NavigatorState> navigatorKey, LoginApi loginApi) =>
    [
      ApiIntegration(loginApi).getMiddlewareBindings(),
      Routing(navigatorKey).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this.api);

  final LoginApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, CheckLoginStatus>(_handleCheckLoginStatus),
        TypedMiddleware<AppState, SignUp>(_handleSignUp),
        TypedMiddleware<AppState, Login>(_handleLogin),
        TypedMiddleware<AppState, LoginUsingGoogle>(_handleLoginUsingGoogle),
        TypedMiddleware<AppState, Logout>(_handleLogout),
      ];

  void _handleCheckLoginStatus(
      Store<AppState> store, CheckLoginStatus action, NextDispatcher next) {
    Future<void> _checkLoginStatus(
        Store<AppState> store, CheckLoginStatus action) async {
      try {
        final user = api.getUser();

        await Future.delayed(const Duration(seconds: 1));

        store.dispatch(CheckLoginStatusSucceeded(user: user));
      } on Exception catch (exception) {
        store.dispatch(CheckLoginStatusFailed(
            exception: ActionException(exception, action)));
      }
    }

    _checkLoginStatus(store, action);
    next(action);
  }

  void _handleSignUp(
      Store<AppState> store, SignUp action, NextDispatcher next) {
    Future<void> _signUp(Store<AppState> store, SignUp action) async {
      try {
        final user = await api.signUp(action.email, action.password);
        if (user != null) {
          store.dispatch(SignUpSucceeded(user: user));
        } else {
          store.dispatch(SignUpFailed(
              exception: ActionException(Exception('Signup Failed'), action)));
        }
      } on Exception catch (exception) {
        store.dispatch(
            SignUpFailed(exception: ActionException(exception, action)));
      }
    }

    _signUp(store, action);
    next(action);
  }

  void _handleLoginUsingGoogle(
      Store<AppState> store, LoginUsingGoogle action, NextDispatcher next) {
    Future<void> _login(Store<AppState> store, LoginUsingGoogle action) async {
      try {
        final user = await api.signInUsingGoogle();
        if (user != null) {
          store.dispatch(LoginUsingGoogleSucceeded(user: user));
        } else {
          store.dispatch(LoginUsingGoogleFailed(
              exception:
                  ActionException(Exception('Google login error.'), action)));
        }
      } on Exception catch (exception) {
        store.dispatch(LoginUsingGoogleFailed(
            exception: ActionException(exception, action)));
      }
    }

    _login(store, action);
    next(action);
  }

  void _handleLogin(Store<AppState> store, Login action, NextDispatcher next) {
    Future<void> _login(Store<AppState> store, Login action) async {
      try {
        final user = await api.signIn(action.email, action.password);
        if (user != null) {
          store.dispatch(LoginSucceeded(user: user));
        } else {
          store.dispatch(LoginFailed(
              exception: ActionException(
                  Exception('Something went wrong. Try again later.'),
                  action)));
        }
      } on Exception catch (exception) {
        store.dispatch(
            LoginFailed(exception: ActionException(exception, action)));
      }
    }

    _login(store, action);
    next(action);
  }

  void _handleLogout(
      Store<AppState> store, Logout action, NextDispatcher next) {
    Future<void> _logout(Store<AppState> store, Logout action) async {
      try {
        await cancelAllSubscriptions();
        await api.signOut();

        store.dispatch(DisposeNotificationClickListener());
        store.dispatch(ClearAllReminder());
        store.dispatch(LogoutSucceeded());
      } on Exception catch (exception) {
        store.dispatch(
            LogoutFailed(exception: ActionException(exception, action)));
      }
    }

    _logout(store, action);
    next(action);
  }
}

class Routing {
  const Routing(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, CheckLoginStatusSucceeded>(
            _routeCheckLoginStatusSucceeded),
        TypedMiddleware<AppState, LoginSucceeded>(_routeLoginSucceeded),
        TypedMiddleware<AppState, LoginUsingGoogleSucceeded>(
            _routeLoginSucceeded),
        TypedMiddleware<AppState, SignUpSucceeded>(_routeLoginSucceeded),
        TypedMiddleware<AppState, LogoutSucceeded>(_routeLogoutSucceeded),
      ];

  NavigatorState get _navigatorState => navigatorKey.currentState!;

  void _routeCheckLoginStatusSucceeded(Store<AppState> store,
      CheckLoginStatusSucceeded action, NextDispatcher next) {
    final routeName = action.user != null ? HomePage.route : LoginPage.route;
    _pushNamedPage(routeName, replaceRoot: true);

    next(action);
  }

  void _routeLogoutSucceeded(
      Store<AppState> store, LogoutSucceeded action, NextDispatcher next) {
    const routeName = LoginPage.route;
    _pushNamedPage(routeName, replaceRoot: true);

    next(action);
  }

  void _routeLoginSucceeded(
      Store<AppState> store, dynamic action, NextDispatcher next) {
    const routeName = HomePage.route;
    _pushNamedPage(routeName, replaceRoot: true);

    next(action);
  }

  void _pushNamedPage(String routeName,
      {bool replaceRoot = false, bool replacePage = false}) {
    if (replaceRoot) {
      _navigatorState.pushNamedAndRemoveUntil(
          routeName, (Route route) => false);
    } else if (replacePage) {
      _navigatorState.pushReplacementNamed(routeName);
    } else {
      _navigatorState.pushNamed(routeName);
    }
  }
}
