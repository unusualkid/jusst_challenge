import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jusst_challenge/utility/size_config.dart';
import 'package:jusst_challenge/utility/strings.dart';
import 'package:jusst_challenge/widgets/playback_icon.dart';
import 'package:jusst_challenge/widgets/progress_bar.dart';
import 'package:jusst_challenge/widgets/song_info.dart';
import 'package:jusst_challenge/widgets/system_toast.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel = IOWebSocketChannel.connect(API.serverHost);

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var coverArtUrl = '';
  var artist = '';
  var title = '';
  var duration = 0;
  var playbackState = PlaybackState.inactive;
  var playbackPosition = 0;
  var volume = 0;
  var systemState = SystemState.waitingForSocket;
  var showVolumeToast = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: widget.channel.stream,
          builder: (context, snapshot) {
            print(snapshot);

            // Parse returned data from websocket
            if (snapshot.hasData) {
              var parsedJson = json.decode(snapshot.data);

              // If there is there is a new song, Parse its metadata
              if (parsedJson[Strings.metaDataKey] != null) {
                playbackState = parsedJson[Strings.playbackKey];
                var metaData = parsedJson[Strings.metaDataKey];

                if (metaData[Strings.coverArtKey] != null) {
                  coverArtUrl = metaData[Strings.coverArtKey];
                }
                if (metaData[Strings.artistKey] != null) {
                  artist = metaData[Strings.artistKey];
                }
                if (metaData[Strings.titleKey] != null) {
                  title = metaData[Strings.titleKey];
                }
                if (metaData[Strings.durationKey] != null) {
                  duration = metaData[Strings.durationKey];
                }
              }

              // Parse the new playbackPosition
              if (parsedJson[Strings.playbackPositionKey] != null) {
                playbackPosition = parsedJson[Strings.playbackPositionKey];
              }

              // Parse new systemState
              if (parsedJson[Strings.systemKey] != null) {
                systemState = parsedJson[Strings.systemKey];
              }

              // Parse new volume and displays toast
              if (parsedJson[Strings.volumeKey] != null) {
                volume = parsedJson[Strings.volumeKey];

                Fluttertoast.showToast(
                  msg: "Volume: $volume",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.grey.withOpacity(0.7),
                  textColor: Colors.white,
                  fontSize: Theme.of(context).textTheme.headline6.fontSize,
                );
              }
            }

            // Stack SystemToast on to pof main view
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SongInfo(
                        url: coverArtUrl,
                        artist: artist,
                        title: title,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: PlaybackIcon(
                              playbackState: playbackState,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: ProgressBar(
                              percent: playbackPosition / duration <= 1.0
                                  ? playbackPosition / duration
                                  : 0.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SystemToast(systemState: systemState),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
