import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "../controller/controller.dart";

import "quiz.dart";
import "welcome.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        //Return button
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const WelcomeScreen();
                  },
                ));
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40),
            )),
        body: Consumer<Controller>(builder: (context, value, child) {
          return Container(
              height: screenHeight,
              color: Colors.blue,
              child: Column(
                children: [
                  //Main container
                  Container(
                      margin: EdgeInsets.only(
                          top: screenHeight / 10,
                          right: screenWidth / 10,
                          left: screenWidth / 10,
                          bottom: screenHeight / 10),
                      width: screenWidth,
                      height: screenHeight / 2,
                      decoration:
                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Texts based on your perfomance
                            Text(value.rightCount > 8 ? "Congrats!" : "Too bad...",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                            Text("${(value.rightCount * 7.75).toStringAsFixed(0)}% Score",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: value.rightCount > 8 ? Colors.green : Colors.red,
                                )),
                            //Goku or Vegeta images
                            SizedBox(
                                height: screenHeight / 3,
                                child: Image.asset(
                                    "assets/images/${value.rightCount > 8 ? "goku" : "vegeta"}.png"))
                          ],
                        ),
                      )),
                  //Replay button
                  IconButton(
                      onPressed: () {
                        value.resetData();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const QuizScreen();
                          },
                        ));
                      },
                      icon: const Icon(Icons.replay, size: 50, color: Colors.white))
                ],
              ));
        }));
  }
}
