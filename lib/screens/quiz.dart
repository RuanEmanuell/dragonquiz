import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame_audio/flame_audio.dart';

import "../controller/controller.dart";
import "../models/questions.dart";
import "results.dart";

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
          return Container(
              height: screenHeight,
              color: Colors.blue,
              child: Stack(
                children: [
                  Column(children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: EdgeInsets.only(
                            left: screenWidth / 20, right: screenWidth / 20, top: screenHeight / 10),
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: value.colorController, borderRadius: BorderRadius.circular(20)),
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            child: Text(json["questions"][value.count]["question"],
                                style: TextStyle(
                                    color: value.tappable ? Colors.black : Colors.white,
                                    fontSize: screenWidth / 20)))),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                          color: value.colorController,
                          borderRadius: BorderRadius.circular(screenWidth / 20)),
                      height: screenHeight / 1.9,
                      margin: EdgeInsets.only(
                          top: screenHeight / 10, left: screenWidth / 20, right: screenWidth / 20),
                      width: screenWidth,
                      child: ListView.builder(
                        itemCount: json["questions"][value.count]["anwsers"].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () async {
                                if (value.tappable) {
                                  value.tappable = false;
                                  Future.delayed(const Duration(seconds: 3), () async {
                                    if (value.count >= json["questions"].length - 1) {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const ResultsScreen();
                                        },
                                      ));
                                      !value.isMuted
                                          ? FlameAudio.play(
                                              value.rightCount > 8 ? "happy.mp3" : "sad.mp3")
                                          : false;
                                    } else {
                                      value.increaseCounter();
                                    }
                                  });
                                  if (json["questions"][value.count]["anwsers"][index] ==
                                      json["questions"][value.count]["correct"]) {
                                    value.rightAnwser();
                                    !value.isMuted ? await FlameAudio.play("right.mp3") : false;
                                  } else {
                                    value.wrongAnwser();
                                    !value.isMuted ? await FlameAudio.play("wrong.mp3") : false;
                                  }
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(screenHeight / 100),
                                  margin: EdgeInsets.all(screenHeight / 100),
                                  decoration: BoxDecoration(
                                      color: value.colorController,
                                      border: Border.all(width: 3, color: Colors.black),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    margin: EdgeInsets.all(screenHeight / 70),
                                    child: Text(json["questions"][value.count]["anwsers"][index],
                                        style: TextStyle(fontSize: screenWidth / 20)),
                                  )));
                        },
                      ),
                    ),
                  ]),
                  !value.tappable
                      ? Container(
                          height: screenHeight / 3,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: screenHeight / 2.25),
                          child: value.isRight
                              ? Image.asset("assets/images/right.png")
                              : Image.asset("assets/images/wrong.png"))
                      : Container(),
                  SafeArea(
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        alignment: Alignment.topLeft,
                        color: value.colorController,
                        width: value.count * screenWidth / 14,
                        height: screenHeight / 40),
                  ),
                ],
              ));
        },
      ),
    ));
  }
}
