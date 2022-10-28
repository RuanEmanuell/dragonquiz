import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "../controller/controller.dart";

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Controller>(context, listen: false);
    return Scaffold(body: Text(data.rightCount.toString()));
  }
}
