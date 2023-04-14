import 'dart:async';
import 'package:flutter/material.dart';

class CountdownProvider extends ChangeNotifier{
  Duration duration = const Duration(seconds: 0);
  bool isRunning =false;

  StreamSubscription<int>? _timerSubscription;

  void startStopTimer(){
    if (!isRunning) {
     _startTimer(duration.inSeconds);
    }  else{
      _timerSubscription?.pause();
    }

    isRunning=!isRunning;
    notifyListeners();
}
  void setCountdownDuration(Duration duration){

    this.duration = duration;
    _timerSubscription?.cancel();
    isRunning=false;
    notifyListeners();
  }
  void _startTimer(int seconds){
    _timerSubscription?.cancel();
    _timerSubscription = Stream<int>.periodic(const Duration(seconds: 1),(computationCount) => seconds-computationCount-1,)
    .take(seconds)
    .listen((timeLeft) {
      duration = Duration(seconds: timeLeft);
      notifyListeners();
    });
  }

  get timeLeft {
    if (duration.inSeconds ==0) {
      _timerSubscription?.cancel();
      isRunning=false;
    }
    final minutes = ((duration.inSeconds /60)%60).floor().toString().padLeft(2,'0');
    final seconds = (duration.inSeconds %60).floor().toString().padLeft(2,'0');
    return '$minutes:$seconds';
  }
}