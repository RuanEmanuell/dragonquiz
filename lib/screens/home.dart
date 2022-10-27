import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import "../controller/controller.dart";
import "../models/questions.dart";

var count = 0;
var rightCount = 0;
bool tappable = true;
var colorController = Colors.white;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<BlocData>(
        create: (_) => BlocData(),
        child: Builder(builder: (context) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(bottom: 20),
                color: Colors.black,
                child: Column(
                  children: [
                    AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.only(top: screenHeight / 10, left: 30, right: 30),
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: colorController, borderRadius: BorderRadius.circular(20)),
                        child: Container(
                            margin: EdgeInsets.all(30),
                            child: Text(json["questions"][count]["question"],
                                style: TextStyle(fontSize: 20)))),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      decoration:
                          BoxDecoration(color: colorController, borderRadius: BorderRadius.circular(20)),
                      height: screenHeight / 1.8,
                      margin: EdgeInsets.only(
                          top: screenHeight / 10, left: 30, right: 30, bottom: screenHeight / 10),
                      width: screenWidth,
                      child: ListView.builder(
                        itemCount: json["questions"][count]["anwsers"].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                if (count < json["questions"].length - 1 && tappable) {
                                  tappable = false;
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      count++;
                                      colorController = Colors.white;
                                    });
                                    tappable = true;
                                  });
                                  if (json["questions"][count]["anwsers"][index] ==
                                      json["questions"][count]["correct"]) {
                                    setState(() {
                                      colorController = Colors.green;
                                    });
                                    rightCount++;
                                  } else {
                                    setState(() {
                                      colorController = Colors.red;
                                    });
                                  }
                                } else {
                                  print(rightCount);
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black, borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(json["questions"][count]["anwsers"][index],
                                        style: TextStyle(fontSize: 20, color: Colors.white)),
                                  )));
                        },
                      ),
                    ),
                  ],
                )),
          ));
        }));
  }
}
