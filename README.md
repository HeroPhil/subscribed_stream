<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A utiliy class for easy stream subscription handling

## Features

* Create a StreamSubscription Object from a Stream
* Transform the event data with the build in callback method
* Cache the latest received event data

## Getting started

* Recommended use inside BLOC or Provider classes

## Usage

```dart
final stream = getRealTimeDataFromDatabase();

final subscribedStream = SubscribedStream<String>(
      stream: stream,
      onStreamEvent: (data, previousData, subscribedStream) {
          if (data != previousData) {
            notifyListeners();
          }
        return data;
      },
    );

// from UI
final latestValue = subscribedStream.latestValue;
```

## Additional information

Don't hesitate to contact me if you have questions or ideas. 
