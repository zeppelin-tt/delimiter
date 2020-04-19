import 'package:commanddelemiter/pages/main/main_page.dart';
import 'package:commanddelemiter/provider/input_data_provider.dart';
import 'package:commanddelemiter/provider/teams_provider.dart';
import 'package:commanddelemiter/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputDataProvider()..init()),
        ChangeNotifierProvider(create: (_) => TeamsProvider()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
