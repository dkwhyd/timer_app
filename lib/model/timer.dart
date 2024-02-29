import 'dart:async';

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
  int shortBreak = 1;
  int longBreak = 20;

  String returnTime(Duration t) {
    String minutes =
        (t.inMinutes < 10) ? '0${t.inMinutes}' : t.inMinutes.toString();

    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = (numSeconds < 10) ? '0$numSeconds' : numSeconds.toString();

    String formattedTime = "$minutes:$seconds";
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (isActive) {
        _time = (_time! - Duration(seconds: 1));
        _radius = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _radius = 1;
          Duration(minutes: work);
          isActive = false;
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
    _fullTime = _time;
  }

  void stopTimer() {
    isActive = false;
    print('stop time');
  }

  void resumeTimer() {
    isActive = true;
  }

  void startTimer() {
    if (_time!.inSeconds > 0) {
      this.isActive = true;
    }
  }

  void startBreak(bool isShort) {
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }
}
