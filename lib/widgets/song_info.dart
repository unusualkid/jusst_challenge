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
                      child: Center(child: CircularProgressIndicator()),
                      color: Theme.of(context).disabledColor,
                      width: double.infinity,
                    ),
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: widget.artist != ''
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        'by ' + widget.artist,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  )
                : CircularProgressIndicator(
                    backgroundColor: Theme.of(context).disabledColor,
                  ),
          ),
        ],
      ),
    );
  }
}
