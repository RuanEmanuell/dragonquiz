import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../controller/controller.dart";
import 'quiz.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: Consumer<Controller>(builder: ((context, value, child) {
      return Container(
          color: Colors.blue,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Image.asset("assets/images/logo.png")),
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                margin: EdgeInsets.only(
                    left: 20, right: 20, top: screenHeight / 100, bottom: screenHeight / 25),
                width: screenWidth,
                height: screenHeight / 7,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    onPressed: () {
                      value.resetData();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const QuizScreen();
                        },
                      ));
                    },
                    child: const Text("Start",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black))),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                          onPressed: () {
                            value.muteController();
                          },
                          icon: Icon(value.isMuted ? Icons.volume_off : Icons.volume_up,
                              size: 50, color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 40),
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.question_mark, size: 45, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ));
    })));
  }
}
