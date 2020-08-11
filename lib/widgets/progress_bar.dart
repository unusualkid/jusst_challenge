import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/size_config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  final percent;

  const ProgressBar({Key key, @required this.percent}) : super(key: key);
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearPercentIndicator(
        width: SizeConfig.safeBlockHorizontal * 63,
        lineHeight: 14.0,
        percent: widget.percent,
        backgroundColor: Theme.of(context).disabledColor,
        progressColor: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
