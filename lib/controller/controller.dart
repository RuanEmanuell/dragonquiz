import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  int count = 0;
  int rightCount = 0;
  var colorController = Colors.white;
  bool isMuted = false;
  bool tappable = true;
  bool isRight = false;

  muteController() {
    isMuted = !isMuted;
    notifyListeners();
  }

  increaseCounter() {
    count++;
    colorController = Colors.white;
    tappable = true;
    notifyListeners();
  }

  rightAnwser() async {
    rightCount++;
    colorController = Colors.green;
    isRight = true;
    notifyListeners();
  }

  wrongAnwser() async {
    colorController = Colors.red;
    isRight = false;
    notifyListeners();
  }

  resetData() {
    colorController = Colors.white;
    tappable = true;
    count = 0;
    rightCount = 0;
    notifyListeners();
  }
}
