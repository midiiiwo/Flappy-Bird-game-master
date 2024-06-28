import 'dart:async';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameStarted = false;
  static double barrierXone = 2;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;
  int highScore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    score = 0;
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        checkCollision();
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
          score++;
          updateHighScore();
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
          score++;
          updateHighScore();
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        gameStarted = false;
        showGameOverDialog();
      }
    });
  }

  void checkCollision() {
    if (birdYaxis <= -1.1 || birdYaxis >= 1.1) {
      gameStarted = false;
      showGameOverDialog();
    }
  }

  void updateHighScore() {
    if (score > highScore) {
      setState(() {
        highScore = score;
      });
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score\nHigh Score: $highScore'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startOver();
              },
              child: Text('Start Over'),
            ),
          ],
        );
      },
    );
  }

  void startOver() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialHeight = birdYaxis;
      barrierXone = 2;
      barrierXtwo = barrierXone + 1.5;
      gameStarted = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(-0.7, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.01),
                    child: gameStarted
                        ? Text("")
                        : Text(
                      "T A P  T O   P L A Y",
                      style:
                      TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.2),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 250.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.2),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.2),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.2),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.yellow,
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('score',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text('$score',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('High score',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text('$highScore',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
