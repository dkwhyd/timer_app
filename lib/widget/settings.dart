// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer/widget/settings_button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;

  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';

  int? workTime;
  int? shortBreak;
  int? longBreak;

  SharedPreferences? prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 24);
    double buttonSize = 4;
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
        SettingButton(
          const Color(0xff455A64),
          "-",
          buttonSize,
          -1,
          setting: 'WORKTIME',
          callback: updateSetting,
        ),
        TextField(
            controller: txtWork,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingButton(
          const Color(0xff009688),
          "+",
          buttonSize,
          1,
          setting: 'WORKTIME',
          callback: updateSetting,
        ),
        Text("Short Break", style: textStyle),
        const Text(""),
        const Text(""),
        SettingButton(
          const Color(0xff455A64),
          "-",
          buttonSize,
          -1,
          setting: 'SHORTBREAK',
          callback: updateSetting,
        ),
        TextField(
            controller: txtShort,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingButton(
          const Color(0xff009688),
          "+",
          buttonSize,
          1,
          setting: 'SHORTBREAK',
          callback: updateSetting,
        ),
        Text(
          "Long Break",
          style: textStyle,
        ),
        const Text(""),
        const Text(""),
        SettingButton(
          const Color(0xff455A64),
          "-",
          buttonSize,
          -1,
          setting: "LONGBREAK",
          callback: updateSetting,
        ),
        TextField(
            controller: txtLong,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingButton(
          const Color(0xff009688),
          "+",
          buttonSize,
          1,
          setting: "LONGBREAK",
          callback: updateSetting,
        )
      ],
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs!.getInt(WORKTIME);

    if (workTime == null) {
      await prefs!.setInt(WORKTIME, int.parse('30'));
    }

    int? shortBreak = prefs!.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs!.setInt(SHORTBREAK, int.parse('15'));
    }

    int? longBreak = prefs!.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs!.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork!.text = workTime!.toString();
      txtShort!.text = shortBreak!.toString();
      txtLong!.text = longBreak!.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case 'WORKTIME':
        {
          int? workTime = prefs?.getInt(WORKTIME);
          workTime = workTime! + value;
          if (workTime >= 1 && workTime <= 180) {
            prefs?.setInt(WORKTIME, workTime);
            setState(() {
              txtWork?.text = workTime.toString();
            });
          }
        }
        break;
      case 'SHORTBREAK':
        {
          int? short = prefs!.getInt(SHORTBREAK);
          short = short! + value;
          if (short >= 1 && short <= 120) {
            prefs?.setInt(SHORTBREAK, short);
            setState(() {
              txtShort!.text = short.toString();
            });
          }
        }
        break;
      case 'LONGBREAK':
        {
          int? long = prefs!.getInt(LONGBREAK);
          long = long! + value;
          if (long >= 1 && long <= 180) {
            prefs?.setInt(LONGBREAK, long);
            setState(() {
              txtLong?.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
