import 'dart:async';
// import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

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

          // Trigger vibration
          Vibration.vibrate(duration: 1000);
        }
      }
      time = returnTime(_time!);

      waktu = time;
      percent = _radius;
      return TimerModel(time, _radius);
    });
  }

  void startWork() {
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

  void startBreak(bool isShort) {
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _saveTime = isShort ? shortBreak : longBreak;
    _fullTime = _time;
  }
}
