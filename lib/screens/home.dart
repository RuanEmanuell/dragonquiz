import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame_audio/flame_audio.dart';

import "../controller/controller.dart";
import "../models/questions.dart";
import "results.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
          return Container(
              padding: EdgeInsets.only(bottom: screenHeight / 10),
              color: Colors.black,
              child: Stack(
                children: [
                  Column(children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: EdgeInsets.only(top: screenHeight / 10, left: 30, right: 30),
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: value.colorController, borderRadius: BorderRadius.circular(20)),
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            child: Text(json["questions"][value.count]["question"],
                                style: TextStyle(
                                    color: value.tappable ? Colors.black : Colors.white,
                                    fontSize: 20)))),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                          color: value.colorController, borderRadius: BorderRadius.circular(20)),
                      height: screenHeight / 1.8,
                      margin: EdgeInsets.only(
                          top: screenHeight / 10, left: 30, right: 30, bottom: screenHeight / 10),
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
                                          return ResultsScreen();
                                        },
                                      ));
                                      await FlameAudio.play(
                                          value.rightCount > 8 ? "happy.mp3" : "sad.mp3");
                                    } else {
                                      value.increaseCounter();
                                    }
                                  });
                                  if (json["questions"][value.count]["anwsers"][index] ==
                                      json["questions"][value.count]["correct"]) {
                                    value.rightAnwser();
                                    await FlameAudio.play("right.mp3");
                                  } else {
                                    value.wrongAnwser();
                                    await FlameAudio.play("wrong.mp3");
                                  }
                                }
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black, borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Text(json["questions"][value.count]["anwsers"][index],
                                        style: const TextStyle(fontSize: 20, color: Colors.white)),
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
