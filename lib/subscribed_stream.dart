library subscribed_stream;

import 'dart:async';

typedef T StreamSubscriptionCallback<T>(
  /// The latest data emitted by the stream.
  T data,
  /// The previous data emitted by the stream.
  T? previous,
  /// This object itself. Use this to i.e. unsubscribe from the stream.
  SubscribedStream<T> self,
);

/// Utility class for subscribing to a stream.
/// 
/// The [stream] is a [Stream] that emits [T] values.
/// The [onStreamEvent] callback is called whenever a new value is emitted.
class SubscribedStream<T> {
  /// The stream which is being subscribed to
  Stream<T> stream;
  /// A list of subscriptions to the stream
  List<StreamSubscription<T>?> subscriptions = [];
  /// The last emitted data of type [T]
  T? latestValue;
  /// Callback to be called when a new value is emitted by the stream
  StreamSubscriptionCallback<T> onStreamEvent;

  /// Constructor
  SubscribedStream({
    /// The stream to subscribe to
    required this.stream,
    /// The callback to be called when a new value is emitted by the stream
    required this.onStreamEvent,
    /// The initial value to be used as latestValue. Default to null.
    this.latestValue,
    /// Whether to automatically subscribe to the stream. Default to true.
    bool initiallySubscribed = true,
  }) {
    if (initiallySubscribed) {
      subscribe();
    }
  }

  /// Subscribe to the stream with the [onStreamEvent] callback.
  /// 
  /// Is being called on construction if [initiallySubscribed] is true.
  /// If this is called multiple times and [unsubscribe] is not called,
  /// the stream will be subscribed multiple times.
  void subscribe() {
    subscriptions.addAll([
      stream.listen((event) {
        latestValue = onStreamEvent.call(event, latestValue, this);
      })
    ]);
  }

  /// Cancels all subscriptions to the stream.
  /// 
  /// Returns a [Future] which completes when all subscriptions are cancelled.
  Future unsubscribe() {
    return Future.wait(
      subscriptions.map(
        (subscription) => subscription?.cancel() ?? Future(() {}),
      ),
    );
  }
}

