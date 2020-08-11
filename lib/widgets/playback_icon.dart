import 'package:flutter/material.dart';

class PlaybackIcon extends StatefulWidget {
  final playbackState;

  const PlaybackIcon({Key key, this.playbackState}) : super(key: key);
  @override
  _PlaybackIconState createState() => _PlaybackIconState();
}

class _PlaybackIconState extends State<PlaybackIcon> {
  @override
  Widget build(BuildContext context) {
    return widget.playbackState == 'inactive'
        ? SizedBox.shrink()
        : CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Icon(
              widget.playbackState == 'playing'
                  ? Icons.play_arrow
                  : Icons.pause,
            ),
          );
  }
}
