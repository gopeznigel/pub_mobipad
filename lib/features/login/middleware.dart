import 'package:flutter/material.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:redux/redux.dart';

import '../../exception/action_exception.dart';
import '../../state.dart';
import '../home/actions.dart';
import '../home/ui/home_page.dart';
import 'actions.dart';
import 'api.dart';
import 'ui/login_page.dart';
import 'ui/signup_page.dart';

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
        TypedMiddleware<AppState, Login>(_handleLogin),
        TypedMiddleware<AppState, LoginUsingGoogle>(_handleLoginUsingGoogle),
        TypedMiddleware<AppState, Logout>(_handleLogout),
        TypedMiddleware<AppState, SignUp>(_handleSignUp),
        TypedMiddleware<AppState, LoginSucceeded>(_handleLoginSucceeded),
        TypedMiddleware<AppState, LoginUsingGoogleSucceeded>(
            _handleLoginUsingGoogleSucceeded),
        TypedMiddleware<AppState, SignUpSucceeded>(_handleSignUpSucceeded),
        TypedMiddleware<AppState, CheckLoginStatusSucceeded>(
            _handleCheckLoginStatusSucceeded),
      ];

  void _handleCheckLoginStatus(
      Store<AppState> store, CheckLoginStatus action, NextDispatcher next) {
    Future<void> _checkLoginStatus(
        Store<AppState> store, CheckLoginStatus action) async {
      try {
        final hasUserId = await api.hasUserId();
        var userId = '';
        if (hasUserId) {
          final user = await api.getUser();
          store.dispatch(StoreUser(user));
          userId = user.userId;
        }

        // Add delay for fake splash screen
        await Future.delayed(Duration(milliseconds: 500));

        store.dispatch(CheckLoginStatusSucceeded(userId, hasUserId));
      } on Exception catch (exception) {
        store.dispatch(
            CheckLoginStatusFailed(ActionException(exception, action)));
      }
    }

    _checkLoginStatus(store, action);
    next(action);
  }

  void _handleLoginUsingGoogle(
      Store<AppState> store, LoginUsingGoogle action, NextDispatcher next) {
    Future<void> _login(Store<AppState> store, LoginUsingGoogle action) async {
      try {
        final user = await api.signInUsingGoogle();
        final hasUserId = await api.hasUserId();
        if (hasUserId) {
          store.dispatch(LoginUsingGoogleSucceeded(user.userId, hasUserId));
          store.dispatch(StoreUser(user));
        } else {
          store.dispatch(LoginUsingGoogleFailed(
              ActionException(Exception("Google login error."), action)));
        }
      } on Exception catch (exception) {
        store.dispatch(
            LoginUsingGoogleFailed(ActionException(exception, action)));
      }
    }

    _login(store, action);
    next(action);
  }

  void _handleLogin(Store<AppState> store, Login action, NextDispatcher next) {
    Future<void> _login(Store<AppState> store, Login action) async {
      try {
        final user = await api.signIn(action.email, action.password);
        final hasUserId = await api.hasUserId();
        store.dispatch(LoginSucceeded(user.userId, hasUserId));
        store.dispatch(StoreUser(user));
      } on Exception catch (exception) {
        store.dispatch(LoginFailed(ActionException(exception, action)));
      }
    }

    _login(store, action);
    next(action);
  }

  void _handleLogout(
      Store<AppState> store, Logout action, NextDispatcher next) {
    Future<void> _logout(Store<AppState> store, Logout action) async {
      try {
        await api.signOut();
        store.dispatch(DisposeNotificationClickListener());
        store.dispatch(ClearAllReminder());
        store.dispatch(LogoutSucceeded());
        store.dispatch(ClearUser());
      } on Exception catch (exception) {
        store.dispatch(LogoutFailed(ActionException(exception, action)));
      }
    }

    _logout(store, action);
    next(action);
  }

  void _handleSignUp(
      Store<AppState> store, SignUp action, NextDispatcher next) {
    Future<void> _signUp(Store<AppState> store, SignUp action) async {
      try {
        final user = await api.signUp(action.email, action.password);
        final hasUserId = await api.hasUserId();
        store.dispatch(SignUpSucceeded(user.userId, hasUserId));
        store.dispatch(StoreUser(user));
      } on Exception catch (exception) {
        store.dispatch(SignUpFailed(ActionException(exception, action)));
      }
    }

    _signUp(store, action);
    next(action);
  }

  void _handleLoginSucceeded(
      Store<AppState> store, LoginSucceeded action, NextDispatcher next) {
    Future<void> _loginSucceeded(
        Store<AppState> store, LoginSucceeded action) async {
      store.dispatch(InitCollection(action.userId));
    }

    _loginSucceeded(store, action);
    next(action);
  }

  void _handleLoginUsingGoogleSucceeded(Store<AppState> store,
      LoginUsingGoogleSucceeded action, NextDispatcher next) {
    Future<void> _loginUsingGoogleSucceeded(
        Store<AppState> store, LoginUsingGoogleSucceeded action) async {
      store.dispatch(InitCollection(action.userId));
    }

    _loginUsingGoogleSucceeded(store, action);
    next(action);
  }

  void _handleSignUpSucceeded(
      Store<AppState> store, SignUpSucceeded action, NextDispatcher next) {
    Future<void> _signUpSucceeded(
        Store<AppState> store, SignUpSucceeded action) async {
      store.dispatch(InitCollection(action.userId));
    }

    _signUpSucceeded(store, action);
    next(action);
  }

  void _handleCheckLoginStatusSucceeded(Store<AppState> store,
      CheckLoginStatusSucceeded action, NextDispatcher next) {
    Future<void> _checkLoginStatusSucceeded(
        Store<AppState> store, CheckLoginStatusSucceeded action) async {
      if (action.hasUserId) {
        store.dispatch(InitCollection(action.userId));
      }
    }

    _checkLoginStatusSucceeded(store, action);
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
            _routeLoginUsingGoogle),
        TypedMiddleware<AppState, LogoutSucceeded>(_routeLogoutSucceeded),
        TypedMiddleware<AppState, SignUpSucceeded>(_routeSignUpSucceeded),
        TypedMiddleware<AppState, OpenSignUpPage>(_routeOpenSignUpPage),
        TypedMiddleware<AppState, OpenLoginPage>(_routeOpenLoginPage),
      ];

  NavigatorState get _navigatorState => navigatorKey.currentState;

  void _routeCheckLoginStatusSucceeded(Store<AppState> store,
      CheckLoginStatusSucceeded action, NextDispatcher next) {
    final routeName = action.hasUserId ? HomePage.route : LoginPage.route;
    _pushNamedPage(routeName, replaceRoot: true);
  }

  void _routeLoginSucceeded(
      Store<AppState> store, LoginSucceeded action, NextDispatcher next) {
    final routeName = HomePage.route;
    _pushNamedPage(routeName, replaceRoot: true);
  }

  void _routeLoginUsingGoogle(Store<AppState> store,
      LoginUsingGoogleSucceeded action, NextDispatcher next) {
    final routeName = HomePage.route;
    _pushNamedPage(routeName, replaceRoot: true);
  }

  void _routeLogoutSucceeded(
      Store<AppState> store, LogoutSucceeded action, NextDispatcher next) {
    final routeName = LoginPage.route;
    _pushNamedPage(routeName, replaceRoot: true);
  }

  void _routeSignUpSucceeded(
      Store<AppState> store, SignUpSucceeded action, NextDispatcher next) {
    final routeName = HomePage.route;
    _pushNamedPage(routeName, replaceRoot: true);
  }

  void _routeOpenSignUpPage(
      Store<AppState> store, OpenSignUpPage action, NextDispatcher next) {
    final routeName = SignUpPage.route;
    _pushNamedPage(routeName, replaceRoot: true);
  }

  void _routeOpenLoginPage(
      Store<AppState> store, OpenLoginPage action, NextDispatcher next) {
    final routeName = LoginPage.route;
    _pushNamedPage(routeName, replaceRoot: true);
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
