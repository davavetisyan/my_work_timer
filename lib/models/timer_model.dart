import 'dart:async';

import 'package:my_time/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerModel {
  String time;
  double percent;

  TimerModel({
    required this.time,
    required this.percent,
  });
}

class CountDownTimer {
  double _radius = 1;
  bool _isActive = false;
  Duration? _time;
  Duration? _fullTime;
  int work = 0;
  int shortBreak = 0;
  int longBreak = 0;

  SharedPreferences? prefs;

  initStorage() async {
    prefs = await SharedPreferences.getInstance();
    _readSettings();
  }

  _readSettings() {
    work = prefs?.getInt(AppConstants.WORKTIME) ?? 30;
    shortBreak = prefs?.getInt(AppConstants.SHORTBREAK) ?? 5;
    longBreak = prefs?.getInt(AppConstants.LONGBREAK) ?? 20;
  }

  setSettings(String key, int value) {
    if (prefs != null) {
      prefs!.setInt(key, value);
    }
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (_time != null && _time!.inSeconds > 0) {
      _isActive = true;
    }
  }

  void startBreak(bool isShort) {
    _radius = 1;
    _time = Duration(
      minutes: isShort ? shortBreak : longBreak,
      seconds: 0,
    );
    _fullTime = _time;
  }

  String returnTime(Duration t) {
    String minutes =
        (t.inMinutes < 10) ? '0${t.inMinutes}' : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds = (numSeconds < 10) ? '0$numSeconds' : numSeconds.toString();
    return '$minutes:$seconds';
  }

  void startWork() {
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
    startTimer();
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time! - const Duration(seconds: 1);
        _radius = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _isActive = false;
        }
        time = returnTime(_time!);
        return TimerModel(time: time, percent: _radius);
      }
      time = returnTime(_time!);
      return TimerModel(time: time, percent: _radius);
    });
  }
}
