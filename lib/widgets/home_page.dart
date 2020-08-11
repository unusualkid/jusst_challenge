import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jusst_challenge/model/state.dart';
import 'package:jusst_challenge/utility/strings.dart';
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
  var duration = -1;
  var playbackState = PlaybackState.inactive;
  var playbackPosition = -1;
  var volume = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

              // if (parsedJson[Strings.volumeKey] != null) {
              //   volume = parsedJson[Strings.volumeKey];
              // }

              // if (parsedJson[Strings.playbackKey] != null) {
              //   playbackState = parsedJson[Strings.playbackKey];
              // }

              // if (parsedJson[Strings.playbackPositionKey] != null) {
              //   playbackPosition = parsedJson[Strings.playbackPositionKey];
              //   duration += playbackPosition;
              // }

              // if (parsedJson[Strings.systemKey] != null) {
              //   if (parsedJson[Strings.systemKey] != SystemState.ready) {}
              // }

            }

            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SongInfoWidget(
                    url: coverArtUrl,
                    artist: artist,
                    title: title,
                  ),
                  Text(snapshot.hasData ? '${snapshot.data}' : ''),
                  Text(snapshot.hasData ? '${snapshot.connectionState}' : ''),
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

class SongInfoWidget extends StatefulWidget {
  final String url;
  final String artist;
  final String title;

  const SongInfoWidget({
    Key key,
    @required this.url,
    @required this.artist,
    @required this.title,
  }) : super(key: key);

  @override
  _SongInfoWidgetState createState() => _SongInfoWidgetState();
}

class _SongInfoWidgetState extends State<SongInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: widget.url != ''
                ? Image.network(
                    widget.url,
                  )
                : AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                    ),
                  ),
          ),
          Text(
            widget.title != '' ? widget.title : '',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            widget.artist != '' ? 'by ' + widget.artist : '',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}

class PlaybackIcon extends StatefulWidget {
  @override
  _PlaybackIconState createState() => _PlaybackIconState();
}

class _PlaybackIconState extends State<PlaybackIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.pause),
    );
  }
}

var coverArtUrl = '';
var artist = '';
var title = '';
var duration = -1;
var playbackState = PlaybackState.inactive;
var playbackPosition = -1;
var volume = -1;
