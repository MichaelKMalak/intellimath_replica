import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'IntelliMath'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int KEYS_COUNT = 9;
  int toBeSummed = 0;
  List<int> numss = [];
  List<int> nums = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  void getNums() {
    toBeSummed = getRandom(10, 20);
    final int sumWillBeDividedOn = getRandom(2, KEYS_COUNT);

    List<int> numsss = List.filled(sumWillBeDividedOn, 0);
    int difference = toBeSummed;

    for (int i = 0; i < numsss.length - 1; i++) {
      numsss[i] = getRandom(0, difference);
      difference -= numsss[i];
    }

    numss = List.of(numsss);

    int sum = 0;
    numss.forEach((num) => sum += num);
    if (sum < toBeSummed) {
      numss.last = toBeSummed - sum;
    }
    numss.removeWhere((e) => e == 0);

    if (numss.length == KEYS_COUNT) {
      nums = numss;
      setState(() {});
      return;
    }

    final res = numss +
        List<int>.generate(
          KEYS_COUNT - numss.length,
          (index) => getRandom(1, toBeSummed - 1),
        );
    res.shuffle();
    nums = res;
    setState(() {});
    //return res;
  }

  @override
  Widget build(BuildContext context) {
    getNums();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(toBeSummed.toString()),
            Text(numss.toString()),
            Text(nums.toString()),
          ],
        ),
      ),
    );
  }
}

getRandom(int min, int max) => Random().nextInt(max - min) + min;
