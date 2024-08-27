import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  var timeNow;

  time() {
    var timenow = DateFormat.jms().format(DateTime.now());
    setState(() {
      timeNow = timenow;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        time();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text('시계 페이지')
      ],
    );
  }
}
