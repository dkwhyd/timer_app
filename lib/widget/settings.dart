import 'package:flutter/material.dart';
import 'package:timer/widget/settings_button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 24);
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(20.0),
      children: [
        Text("Work", style: textStyle),
        const Text(""),
        const Text(""),
        const SettingButton(Color(0xff455A64), "-", -1),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        const SettingButton(
          Color(0xff009688),
          "+",
          1,
        ),
        Text("Short Break", style: textStyle),
        const Text(""),
        const Text(""),
        const SettingButton(
          Color(0xff455A64),
          "-",
          -1,
        ),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        const SettingButton(Color(0xff009688), "+", 1),
        Text(
          "Long Break",
          style: textStyle,
        ),
        const Text(""),
        const Text(""),
        const SettingButton(
          Color(0xff455A64),
          "-",
          -1,
        ),
        TextField(
          
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        const SettingButton(
          Color(0xff009688),
          "+",
          1,
        )
      ],
    );
  }
}
