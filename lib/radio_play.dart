import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio/common.dart';
import 'package:radio/lottiescreen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';

class RadioUi extends StatefulWidget {
  const RadioUi({Key? key}) : super(key: key);

  @override
  State<RadioUi> createState() => _RadioUiState();
}

class _RadioUiState extends State<RadioUi> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(
        Uri.parse("https://stream.zeno.fm/n88bnx2a0xhvv"),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '1',
          // Metadata to display in the notification:
          album: "Playing",
          title: "Faith Radio",
          artUri: Uri.parse(
              'https://firebasestorage.googleapis.com/v0/b/notify-cc847.appspot.com/o/zion%20radio.jpeg?alt=media&token=62123633-b815-4e57-bb53-2a208fb06477'),
        ),
      ));
    } catch (e) {
      // print("Error loading audio source: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Container(
            child: Text('Faith Radio'),
          ),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Faith Radio"),
              accountEmail: Text("Connect with us"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "FR",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.facebook,
                  color: Colors.blue, size: 30),
              title: const Text(
                'Facebook',
              ),
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://www.facebook.com/Zionwayradio-109645215221435/');

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  FaIcon(FontAwesomeIcons.youtube, color: Colors.red, size: 30),
              title: const Text(
                'Youtube',
              ),
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://www.youtube.com/channel/UCimib4j_ayASl-1jPbFsNyg');

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.instagram,
                  color: Colors.red, size: 30),
              title: const Text(
                'Instagram',
              ),
              onTap: () async {
                final Uri url =
                    Uri.parse('https://www.instagram.com/official_waterradio/');

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.twitter,
                  color: Colors.blue, size: 30),
              title: const Text(
                'Twitter',
              ),
              // image: Image.asset('lib/icons/facebook.png'),
              onTap: () async {
                final Uri url = Uri.parse('https://twitter.com/waterradio3');

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 189, 61, 189)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('lib/images/zionradio.jpg'),
            ),
          ),
          Container(
            child: Expanded(
                child: SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.4, 0.7, 0.9],
                    colors: [
                      Color(0xFF3594DD),
                      Color(0xFF4563DB),
                      Color(0xFF5036D5),
                      Color(0xFF5816DB),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Faith',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'the substance of things hoped for',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'AkayaTelivigala'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'off air',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.shuffle,
                          color: Colors.white,
                        ),
                        // Icon(
                        //   Icons.repeat,
                        //   color: Colors.white,
                        // ),
                        LottieScreen(),
                        StreamBuilder<PositionData>(
                          stream: positionDataStream,
                          builder: (context, snapshot) {
                            final positionData = snapshot.data;
                            // print(positionData?.position);
                            // return SeekBar(
                            //   duration: positionData?.duration ?? Duration.zero,
                            //   position: positionData?.position ?? Duration.zero,
                            //   bufferedPosition:
                            //       positionData?.bufferedPosition ??
                            //           Duration.zero,
                            //   onChangeEnd: _player.seek,
                            // );
                            return Text("00:00",
                                style: TextStyle(color: Colors.white));
                          },
                        ),
                      ],
                    ),
                    ControlButtons(_player),
                  ],
                ),
                // color: Colors.deepPurple,
              ),
              width: double.infinity,
            )),
          )
        ],
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // IconButton(
        //   icon: const Icon(Icons.volume_up),
        //   onPressed: () {
        //     showSliderDialog(
        //       context: context,
        //       title: "Radio volume",
        //       divisions: 10,
        //       min: 0.0,
        //       max: 1.0,
        //       value: player.volume,
        //       stream: player.volumeStream,
        //       onChanged: player.setVolume,
        //     );
        //   },
        // ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(
                  color: Color.fromRGBO(108, 184, 186, 1),
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return (Text(""));
            }
          },
        ),
      ],
    );
  }
}
