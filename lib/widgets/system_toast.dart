import 'package:flutter/material.dart';
import 'package:jusst_challenge/utility/strings.dart';

class SystemToast extends StatelessWidget {
  final String systemState;

  const SystemToast({Key key, this.systemState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return SystemToast if state is not ready, else return nothing
    if (systemState != SystemState.ready) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.7),
          ),
          child: Text(
            Strings.systemKey + ' ' + systemState,
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
