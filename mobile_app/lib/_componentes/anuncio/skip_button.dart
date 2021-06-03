import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app/_themes/colors.dart';

class SkipButton extends StatefulWidget {
  final onSkip;
  final waitInSeconds;

  const SkipButton({required this.onSkip, required this.waitInSeconds});

  @override
  _SkipButtonState createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  late int counter;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    makeTimer();
  }

  void makeTimer() {
    counter = widget.waitInSeconds;

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (counter > 0)
        setState(() => counter--);
      else
        timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => widget.onSkip(counter > 0),
        child: Text(counter > 0 ? 'Saltar en $counter' : 'Saltar'),
        autofocus: false,
      style: ElevatedButton.styleFrom(
        primary: ThemeColors.darkBgWithOpacity,
        minimumSize: Size(150,50),
        textStyle: TextStyle(fontSize: 20)
      ),
    );
  }
}
