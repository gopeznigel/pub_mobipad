import 'dart:async';

import 'package:mobipad/core/dtos.dart';

// Notes Stream Subscription
StreamSubscription<List<NoteDto>>? notesUpdateSubscription;

/// Cancels all active subscriptions
///
/// Called on successful logout.
Future<void> cancelAllSubscriptions() async {
  await notesUpdateSubscription?.cancel();
}
