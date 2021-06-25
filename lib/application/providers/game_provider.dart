import 'dart:math';

import 'package:flutter/material.dart';
import 'package:darq/darq.dart';

import '../../utils.dart';

class GameProvider extends ChangeNotifier {
  static const int KEYS_COUNT = 9;
  static const int ROUND_TIME_IN_SECONDS = 8;

  int currentTime = GameProvider.ROUND_TIME_IN_SECONDS;
  bool isGameOver = false;
  int currentScore = 0;
  int highScore = 0;
  int targetSum = 15;
  List<int> keyNumbers = List.generate(KEYS_COUNT, (index) => index + 1);
  List<int> selectedKeyIndices = List.empty(growable: true);
  bool startTimerTrigger = false;

  void startGame() {
    isGameOver = false;
    currentScore = 0;
    selectedKeyIndices.clear();
    _startNextRound();
  }

  void _onSuccess() {
    currentScore += currentTime;
    selectedKeyIndices.clear();
    _startNextRound();
    notifyListeners();
  }

  void _startNextRound() {
    targetSum = _randomizeTargetSum();
    keyNumbers = _resetKeyNumbers();
    _resetTimer();
    notifyListeners();
  }

  void gameOver() {
    isGameOver = true;
    highScore = max(highScore, currentScore);
    currentScore = 0;
    selectedKeyIndices.clear();
    notifyListeners();
  }

  int _randomizeTargetSum() {
    return Utils.getBoundedRandomNumber(10, 20);
  }

  List<int> _divideTargetSumOnListOfNumbers() {
    final sumWillBeDividedOn = Utils.getBoundedRandomNumber(2, KEYS_COUNT + 1);
    final resultedNumList = List.generate(sumWillBeDividedOn, (_) => 0);
    var difference = targetSum;
    for (var i = 0; i < resultedNumList.length - 1; i++) {
      resultedNumList[i] = Utils.getBoundedRandomNumber(0, difference);
      difference -= resultedNumList[i];
    }
    final sum = resultedNumList.sum() as int;
    if (sum < targetSum) {
      resultedNumList.last = targetSum - sum;
    }
    resultedNumList.removeWhere((e) => e == 0);
    return resultedNumList;
  }

  List<int> _resetKeyNumbers() {
    final targetDividedNumList = _divideTargetSumOnListOfNumbers();
    if (targetDividedNumList.length == KEYS_COUNT) {
      return targetDividedNumList;
    }
    final generatedRandomRestOfList = List<int>.generate(
      KEYS_COUNT - targetDividedNumList.length,
      (index) => Utils.getBoundedRandomNumber(1, targetSum - 1),
    );
    final newKeyNumbers = targetDividedNumList + generatedRandomRestOfList;
    newKeyNumbers.shuffle();
    return newKeyNumbers;
  }

  void _resetTimer() {
    startTimerTrigger = !startTimerTrigger;
  }

  bool isKeyPressed(int index) {
    return selectedKeyIndices.contains(index);
  }

  void onKeyPressed(int index) {
    if (isKeyPressed(index)) {
      selectedKeyIndices.remove(index);
    } else {
      selectedKeyIndices.add(index);
    }
    if (targetSum == _sumSelectedNumbers()) {
      _onSuccess();
    } else {
      notifyListeners();
    }
  }

  int _sumSelectedNumbers() {
    if (selectedKeyIndices.isEmpty) return 0;
    final s = keyNumbers.select((element, index) {
      return selectedKeyIndices.contains(index) ? element : 0;
    }).sum() as int;
    return s;
  }
}
