import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/strings.dart';

class SystemToast extends StatefulWidget {
  final message;

  const SystemToast({Key key, @required this.message}) : super(key: key);

  @override
  _SystemToastState createState() => _SystemToastState();
}

class _SystemToastState extends State<SystemToast> {
  bool hideToast = false;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      setState(() {
        hideToast = true;
      });
    });

    if (widget.message != SystemState.ready) {
      if (!hideToast) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey.withOpacity(0.7),
            child: Text(
              Strings.systemKey + ' ' + widget.message,
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
              ),
            ),
          ),
        );
      }
    }
    hideToast = false;
    return SizedBox.shrink();
  }
}
