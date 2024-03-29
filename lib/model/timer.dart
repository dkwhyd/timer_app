import 'dart:io';

import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './timermodel.dart';

class CountDownTimer {
  double _radius = 1;
  bool isActive = true;
  Timer? timer;
  String? waktu;
  double percent = 1;
  Duration? _time;
  Duration? _fullTime;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;
  int? _saveTime;
  int durationVibration = 500;

  String returnTime(Duration t) {
    String minutes =
        (t.inMinutes < 10) ? '0${t.inMinutes}' : t.inMinutes.toString();

    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = (numSeconds < 10) ? '0$numSeconds' : numSeconds.toString();

    String formattedTime = "$minutes:$seconds";
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (isActive) {
        _time = (_time! - const Duration(seconds: 1));
        _radius = _time!.inSeconds / _fullTime!.inSeconds;

        // If timer reaches 0 seconds
        if (_time!.inSeconds <= 0) {
          _radius = 1;
          _time = Duration(minutes: _saveTime!);
          isActive = false;
          startVibrationAndToast();
        }
      }
      time = returnTime(_time!);

      waktu = time;
      percent = _radius;
      return TimerModel(time, _radius);
    });
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = (prefs.getInt('workTime') ?? 30);
    shortBreak =
        prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak')!;
    longBreak =
        prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak')!;
    durationVibration = prefs.getInt('durationVibration') == null
        ? 500
        : prefs.getInt('durationVibration')!;
  }

  void startWork() async {
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _saveTime = work;
    _fullTime = _time;
  }

  void stopTimer() {
    isActive = false;
  }

  void resumeTimer() {
    isActive = true;
  }

  void startTimer() {
    if (_time!.inSeconds > 0) {
      isActive = true;
    }
  }

  void startVibrationAndToast() async {
    readSettings();
    if (Platform.isAndroid || Platform.isIOS) {
      Vibration.vibrate(duration: durationVibration);
      Fluttertoast.showToast(
        msg: "Time's up",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  void startBreak(bool isShort) async {
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _saveTime = isShort ? shortBreak : longBreak;
    _fullTime = _time;
  }
}
