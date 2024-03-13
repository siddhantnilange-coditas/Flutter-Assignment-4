import 'dart:async';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer? watchTimer;

  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  bool isStart = true;

  String secondsDuration = "00";
  String minutesDuration = "00";
  String hoursDuration = "00";

  void onStart() {
    isStart = false;
    watchTimer = Timer.periodic(
        const Duration(seconds: 1),
        (watchTimer) => setState(() {
              seconds++;
              if (seconds > 59) {
                seconds = 0;
                minutes++;
                if (minutes > 59) {
                  minutes = 0;
                  hours++;
                }
              }
              if (seconds < 10) {
                secondsDuration = '0$seconds';
              } else {
                secondsDuration = '$seconds';
              }

              if (minutes < 10) {
                minutesDuration = '0$minutes';
              } else {
                minutesDuration = '$minutes';
              }

              if (hours < 10) {
                hoursDuration = '0$hours';
              } else {
                hoursDuration = '$hours';
              }
            }));
  }

  void onStop() {
    setState(() {
      isStart = true;
      watchTimer!.cancel();
    });
  }

  void resetWatch() {
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondsDuration = '00';
      minutesDuration = '00';
      hoursDuration = '00';
      watchTimer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Container(
                    //   width: 300,
                    //   height: 300,
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     border: Border.all(
                    //         color: Color.fromARGB(202, 228, 39, 212), width: 8),
                    //   ),
                    //   // child: Text(
                    //   //   '$hoursDuration : $minutesDuration : $secondsDuration',
                    //   //   style: const TextStyle(
                    //   //     color: Colors.black,
                    //   //     fontSize: 40,
                    //   //     fontWeight: FontWeight.bold,
                    //   //   ),
                    //   // ),
                    // ),
                    Text(
                      '$hoursDuration : $minutesDuration : $secondsDuration',
                      style: const TextStyle(
                        color: Colors.black,
                        // fontFamily: 'Digital-7',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height: 300,
                        width: 300,
                        child: CircularProgressIndicator(
                          value: seconds.toDouble() / 60,
                          strokeWidth: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      child: CupertinoButton(
                        onPressed: isStart ? onStart : onStop,
                        color: Colors.green,
                        padding: const EdgeInsets.all(5),
                        // child: const Text("Play/Pause"),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Play/Pause"),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 130,
                      child: CupertinoButton(
                        onPressed: resetWatch,
                        color: Colors.red,
                        padding: const EdgeInsets.all(5),
                        child: const Text("Reset"),
                        // child:
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
