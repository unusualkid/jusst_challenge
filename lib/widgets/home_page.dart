import 'dart:convert';
import 'package:flutter/material.dart';
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
  TextEditingController _controller = TextEditingController();
  var coverArtUrl = '';
  var artist = '';
  var title = '';

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
                    Text(snapshot.hasData
                        ? '${snapshot.data}'
                        : 'snapshot.data'),
                    Text(snapshot.hasData
                        ? '${snapshot.connectionState}'
                        : 'snapshot.connectionState'),
                  ],
                ),
              );
            }
            return Text('Error: Check your internet.');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
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
    if (widget.url != '') {
      return Column(
        children: [
          Container(
            child: Image.network(
              widget.url,
            ),
          ),
          Text(widget.title),
          Text('by ' + widget.artist),
        ],
      );
    }
    return Column(
      children: [
        Container(
          height: 250,
          width: 250,
          color: Colors.grey[300],
        ),
        Text('title'),
        Text('by artist'),
      ],
    );
  }
}
