import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/size_config.dart';
import 'package:jusst_challenge/utility/strings.dart';
import 'package:jusst_challenge/widgets/playback_icon.dart';
import 'package:jusst_challenge/widgets/progress_bar.dart';
import 'package:jusst_challenge/widgets/song_info.dart';
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
  var playbackState = 'inactive';
  var playbackPosition = 0;
  var volume = -1;
  var systemState = '';

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
            if (snapshot.hasData) {
              var parsedJson = json.decode(snapshot.data);

              if (parsedJson[Strings.metaDataKey] != null) {
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

              if (parsedJson[Strings.volumeKey] != null) {
                volume = parsedJson[Strings.volumeKey];
              }

              if (parsedJson[Strings.playbackKey] != null) {
                playbackState = parsedJson[Strings.playbackKey];
              }

              if (parsedJson[Strings.playbackPositionKey] != null) {
                playbackPosition = parsedJson[Strings.playbackPositionKey];
              }

              if (parsedJson[Strings.systemKey] != null) {
                systemState = parsedJson[Strings.systemKey];
              }
            }

            return Container(
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
