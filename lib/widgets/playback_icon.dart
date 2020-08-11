import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/strings.dart';

class PlaybackIcon extends StatefulWidget {
  final playbackState;

  const PlaybackIcon({Key key, @required this.playbackState}) : super(key: key);
  @override
  _PlaybackIconState createState() => _PlaybackIconState();
}

class _PlaybackIconState extends State<PlaybackIcon> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: widget.playbackState == PlaybackState.inactive
          ? Theme.of(context).disabledColor
          : Theme.of(context).primaryColorLight,
      child: widget.playbackState == PlaybackState.inactive
          ? SizedBox.shrink()
          : Icon(
              widget.playbackState == PlaybackState.playing
                  ? Icons.play_arrow
                  : Icons.pause,
            ),
    );
  }
}
