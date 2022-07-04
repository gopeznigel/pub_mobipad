import 'package:mobipad/core/actions.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/home/actions.dart';
import 'package:mobipad/services/stream_subscription.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import 'api.dart';

List<Middleware<AppState>> getMiddleware(HomeApi homeApi) => [
      ApiIntegration(homeApi).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this.api);

  final HomeApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, ListenToNotesUpdates>(
            _handleListenToNotesUpdates),
        TypedMiddleware<AppState, GetSortedNotes>(_handleGetSortedNotes),
      ];

  void _handleGetSortedNotes(
      Store<AppState> store, GetSortedNotes action, NextDispatcher next) {
    Future<void> _getSortedNotes(
        Store<AppState> store, GetSortedNotes action) async {
      try {
        final notes = await api.getSortedNotes(action.sort);

        store.dispatch(OnNotesUpdates(notes: notes));
      } on Exception catch (e) {
        throw ActionException(e, action);
      }
    }

    _getSortedNotes(store, action);
    next(action);
  }

  void _handleListenToNotesUpdates(
      Store<AppState> store, ListenToNotesUpdates action, NextDispatcher next) {
    next(action);

    _listenToNotesUpdates(store, action);
  }

  /// This function starts a stream subscription on getting notes updates
  _listenToNotesUpdates(Store<AppState> store, ListenToNotesUpdates action) {
    notesUpdateSubscription?.cancel();
    // ignore: cancel_subscriptions
    notesUpdateSubscription = api.getNotesAsStream(action.sort).listen((notes) {
      store.dispatch(OnNotesUpdates(notes: notes));
    });
  }
}
