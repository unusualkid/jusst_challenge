import 'package:flutter/material.dart';

class SongInfo extends StatefulWidget {
  final String url;
  final String artist;
  final String title;

  const SongInfo({
    Key key,
    @required this.url,
    @required this.artist,
    @required this.title,
  }) : super(key: key);

  @override
  _SongInfoState createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
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
