// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

// import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
// import 'package:radio/common.dart';
import 'package:radio/radio_play.dart';
// import 'package:rxdart/rxdart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  //the next two lines are used to persist the splash screen till all init is done//
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  await FirebaseMessaging.instance.subscribeToTopic("zionwayradioPush");
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioUi(),
    );
  }
}
