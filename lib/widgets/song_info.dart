import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/size_config.dart';

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
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).disabledColor,
                  ),
                  height: SizeConfig.safeBlockVertical * 50,
                ),
              ),
              Container(
                child: CachedNetworkImage(
                  imageUrl: widget.url,
                  imageBuilder: (context, imageProvider) => AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: widget.artist != ''
                ? Column(
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'by ' + widget.artist,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
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
