import 'dart:async';

import 'package:flappybird_flutter/bird.dart';
import 'package:flappybird_flutter/obstacles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = -0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  static double barrierXone = 1.5;
  double barrierXtwo = barrierXone + 2;

  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  startGame() {
    gameHasStarted = true;

    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4 * time * time + 2 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      setState(() {
        if (barrierXone < -1.7) {
          barrierXone += 4.4;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -1.7) {
          barrierXtwo += 4.4;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdIsDead()) {
        _showDialog();
        timer.cancel();
      }

      time += 0.01;
    });
  }

  bool birdIsDead() {
    if (birdYaxis < -1.2 || birdYaxis > 1) {
      return true;
    }
    return false;
  }

  _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.brown,
        title: const Center(
          child: Text('Fim de Jogo!',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: resetGame,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: const EdgeInsets.all(7),
                color: Colors.white,
                child: const Text(
                  'Jogar Novamente'
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
      barrierXone = 1.5;
      barrierXtwo = barrierXone + 2;
     });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 1),
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Obstacles(
                        size: 160.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,-1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Obstacles(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Obstacles(
                        size: 240.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,-1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const Obstacles(
                        size: 130.0,
                      ),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.35),
                      child: gameHasStarted
                          ? const Text("")
                          : const Text(
                        "Clique para começar",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ],
                )),
            Container(height: 5, color: Colors.green),
            Expanded(
                child: Container(
                color: Colors.brown,
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
