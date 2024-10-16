import 'dart:math';
import 'package:flutter/material.dart';

final List<Color> colorsList = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.lightBlue,
  Colors.blue,
  Colors.purple,
  Colors.brown,
  Colors.cyan,
  Colors.indigo,
  Colors.lime,
  Colors.lightGreen,
  Colors.pink,
  Colors.teal,
];

class ClassicGameModel extends ChangeNotifier {
  int? focusedBottle;
  List<Color> targetColorsList = [];
  List<Color> dragColorsList = [];
  List<bool> pinedBottlesList = [];
  int colorsMatchingCount = 0;
  int score = 0;
  int scoreFactor = 100;
  bool pinMode = false;

  ClassicGameModel() {
    init();
  }

  void init() {
    targetColorsList = getRandomColorsList(9, colorsList);
    pinedBottlesList = fillWithFalses(9);
    dragColorsList = targetColorsList.toList();
    dragColorsList.shuffle();
    matchCount();
  }

  void restart() {
    init();
    pinMode = false;
    score = 0;
    notifyListeners();
  }

  void onPinTap() {
    pinMode = !pinMode;
    notifyListeners();
  }

  void onBottleTap(int index) {
    if (pinMode == false) {
      if (pinedBottlesList[index] == false) {
        if (focusedBottle == null) {
          focusedBottle = index;
        } else {
          final jar = dragColorsList[focusedBottle!];
          dragColorsList[focusedBottle!] = dragColorsList[index];
          dragColorsList[index] = jar;
          focusedBottle = null;
          matchCount();
        }
      }
    } else {
      pinedBottlesList[index] = !pinedBottlesList[index];
    }
    notifyListeners();
  }

  void onDragTargetDrop({
    required int oldIndex,
    required int newIndex,
  }) {
    if (pinedBottlesList[oldIndex] == false &&
        pinedBottlesList[newIndex] == false) {
      final jar = dragColorsList[oldIndex];
      dragColorsList[oldIndex] = dragColorsList[newIndex];
      dragColorsList[newIndex] = jar;
      focusedBottle = null;
      matchCount();
      notifyListeners();
    }
  }

  List<Color> getRandomColorsList(int quantity, List<Color> colorsList) {
    colorsList.shuffle();
    List<Color> list = [];
    int count;
    count = min(quantity, colorsList.length);
    for (var i = 0; i < count; i++) {
      list.add(colorsList[i]);
    }
    return list;
  }

  List<bool> fillWithFalses(int count) {
    final List<bool> list = [];
    for (var i = 0; i < count; i++) {
      list.add(false);
    }
    return list;
  }

  void matchCount() {
    int count = 0;
    for (var i = 0; i < targetColorsList.length; i++) {
      if (targetColorsList[i] == dragColorsList[i]) {
        count++;
      }
    }
    colorsMatchingCount = count;
  }
}
