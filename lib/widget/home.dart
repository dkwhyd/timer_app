import 'package:flutter/material.dart';
import 'package:timer/widget/timer_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double defaultPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: TimerButton(
                        size: 15,
                        color: const Color(0xff009688),
                        text: "Work",
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: TimerButton(
                        size: 15,
                        color: const Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: TimerButton(
                        size: 15,
                        color: const Color(0xff455A64),
                        text: "Long Break",
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: Text('hello'),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: TimerButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    onPressed: emptyMethod,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: TimerButton(
                  color: Color(0xff009688),
                  text: 'Restart',
                  onPressed: emptyMethod,
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
        ));
  }

  void emptyMethod() {}
}
