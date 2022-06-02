import 'package:first/page/time_page.dart';
import 'package:flutter/material.dart';

import 'jogador_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, clild) {
        return MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.green, brightness: Brightness.dark),
            initialRoute: '/jogador',
            routes: {
              '/jogador': (context) => JogadorPage(),
              '/time': (context) => TimePage()
            });
      },
    );
  }
}

class AppController extends ChangeNotifier {
  static AppController instance = AppController();
}
