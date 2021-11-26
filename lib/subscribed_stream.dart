library subscribed_stream;

import 'dart:async';

typedef T StreamSubscriptionCallback<T>(
  T data,
  T? previous,
  SubscribedStream<T> self,
);

/// Bean class holding a stream and corresponding subscriptions
class SubscribedStream<T> {
  Stream<T> stream;
  List<StreamSubscription<T>?> subscriptions = [];
  T? latestValue;
  StreamSubscriptionCallback<T> onStreamEvent;

  SubscribedStream({
    required this.stream,
    required this.onStreamEvent,
    this.latestValue,
    bool initiallySubscribed = true,
  }) {
    if (initiallySubscribed) {
      subscribe();
    }
  }

  void subscribe() {
    subscriptions.addAll([
      stream.listen((event) {
        latestValue = onStreamEvent.call(event, latestValue, this);
      })
    ]);
  }

  Future unsubscribe() {
    return Future.wait(
      subscriptions.map(
        (subscription) => subscription?.cancel() ?? Future(() {}),
      ),
    );
  }
}

