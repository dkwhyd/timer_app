import 'package:flutter/material.dart';
import 'package:timer/model/timer.dart';
import 'package:timer/model/timermodel.dart';
import 'package:timer/widget/settings_screen.dart';
import 'package:timer/widget/timer_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  String buttonResume = 'Resume';

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) => {
              if (s == 'Settings') {gotoSettings(context)}
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxHeight;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: TimerButton(
                            size: 15,
                            color: const Color(0xff009688),
                            text: "Work",
                            onPressed: () => timer.startWork())),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: TimerButton(
                            size: 15,
                            color: const Color(0xff607D8B),
                            text: "Short Break",
                            onPressed: () => timer.startBreak(true))),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: TimerButton(
                            size: 15,
                            color: const Color(0xff455A64),
                            text: "Long Break",
                            onPressed: () => timer.startBreak(false))),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                    initialData: TimerModel("00:00", 1),
                    stream: timer.stream(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return CircularPercentIndicator(
                        radius: availableWidth / 4,
                        lineWidth: 10.0,
                        percent: timer.percent,
                        center: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (timer.waktu == null)
                                        ? "00:00"
                                        : timer.waktu.toString(),
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  ElevatedButton(
                                      onPressed: () => {gotoSettings(context)},
                                      child: const Text('Settings'))
                                ],
                              ),
                            ),
                          ],
                        ),
                        progressColor: const Color(0xff009688),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: TimerButton(
                        color: const Color(0xff212121),
                        text: "Stop",
                        onPressed: () => timer.stopTimer(),
                        size: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: TimerButton(
                      color: const Color(0xff009688),
                      text: "Resume",
                      onPressed: () => {
                        if (!timer.isActive) {timer.resumeTimer()}
                      },
                      size: 15,
                    )),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void gotoSettings(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }
}
