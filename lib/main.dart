import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'controller/controller.dart';
import 'screens/welcome.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(milliseconds: 500), () {
    FlutterNativeSplash.remove();
  });
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
            create: (_) {
              Controller();
            },
            child: const WelcomeScreen()));
  }
}
