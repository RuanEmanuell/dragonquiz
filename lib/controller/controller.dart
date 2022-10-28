import "package:flutter/material.dart";

class Controller extends ChangeNotifier {
  int count = 0;
  int rightCount = 0;
  var colorController = Colors.white;
  bool tappable = true;
  bool isRight = false;

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

  @override
  notifyListeners();
}
