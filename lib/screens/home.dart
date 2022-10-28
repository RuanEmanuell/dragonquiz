import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../controller/controller.dart";
import "../models/questions.dart";
import "results.dart";

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var data = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(bottom: 20),
          color: Colors.black,
          child: Stack(
            children: [
              Column(children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    margin: EdgeInsets.only(top: screenHeight / 10, left: 30, right: 30),
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: data.colorController, borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        margin: EdgeInsets.all(30),
                        child: Text(json["questions"][data.count]["question"],
                            style: TextStyle(
                                color: data.tappable ? Colors.black : Colors.white, fontSize: 20)))),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      color: data.colorController, borderRadius: BorderRadius.circular(20)),
                  height: screenHeight / 1.8,
                  margin: EdgeInsets.only(
                      top: screenHeight / 10, left: 30, right: 30, bottom: screenHeight / 10),
                  width: screenWidth,
                  child: ListView.builder(
                    itemCount: json["questions"][data.count]["anwsers"].length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            if (data.tappable) {
                              data.tappable = false;
                              Future.delayed(Duration(seconds: 3), () {
                                if (data.count >= json["questions"].length - 1) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ResultsScreen();
                                    },
                                  ));
                                } else {
                                  setState(() {
                                    data.increaseCounter();
                                  });
                                }
                              });
                              if (json["questions"][data.count]["anwsers"][index] ==
                                  json["questions"][data.count]["correct"]) {
                                setState(() {
                                  data.rightAnwser();
                                });
                              } else {
                                setState(() {
                                  data.wrongAnwser();
                                });
                              }
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(json["questions"][data.count]["anwsers"][index],
                                    style: TextStyle(fontSize: 20, color: Colors.white)),
                              )));
                    },
                  ),
                ),
              ]),
              !data.tappable
                  ? Container(
                      height: screenHeight / 2,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: screenHeight / 3),
                      child: data.isRight
                          ? Image.asset("assets/images/right.png")
                          : Image.asset("assets/images/wrong.png"))
                  : Container()
            ],
          )),
    ));
  }
}
