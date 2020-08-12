import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/strings.dart';

class VolumeToast extends StatefulWidget {
  final volume;
  final Function onChanged;

  const VolumeToast({Key key, this.volume, this.onChanged}) : super(key: key);
  @override
  _VolumeToastState createState() => _VolumeToastState();
}

class _VolumeToastState extends State<VolumeToast> {
  bool hideToast = false;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    timer = Timer(Duration(seconds: 3), () {
      setState(() {
        hideToast = true;
      });
    });

    if (!hideToast) {
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey.withOpacity(0.7),
          child: Text(
            Strings.volumeKey + ': ' + widget.volume.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
            ),
          ),
        ),
      );
    }

    return SizedBox.shrink();
  }
}
