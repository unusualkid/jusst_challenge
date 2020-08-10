import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/strings.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel = IOWebSocketChannel.connect(API.serverHost);
  final String coverArtUrl;

  HomePage({Key key, @required this.title, this.coverArtUrl}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

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
              var coverArtUrl = '';
              if (parsedJson['metadata'] != null) {
                if (parsedJson['metadata']['coverArt'] != null) {
                  print(parsedJson['metadata']['coverArt']);
                  coverArtUrl = parsedJson['metadata']['coverArt'];
                }
              }
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CoverArt(
                      url: coverArtUrl,
                    ),
                    Text('title'),
                    Text(
                        snapshot.hasData ? '${snapshot.data}' : 'Hello World!'),
                    Text(snapshot.hasData
                        ? '${snapshot.connectionState}'
                        : 'Hello World!'),
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

class CoverArt extends StatefulWidget {
  final String url;

  const CoverArt({Key key, @required this.url}) : super(key: key);

  @override
  _CoverArtState createState() => _CoverArtState();
}

class _CoverArtState extends State<CoverArt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        widget.url,
      ),
    );
  }
}
