import 'package:first/service/rest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/menu_component.dart';

class JogadorPage extends StatefulWidget {
  const JogadorPage({Key? key}) : super(key: key);

  @override
  State<JogadorPage> createState() => _JogadorPageState();
}

class _JogadorPageState extends State<JogadorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuComponente(),
      appBar: AppBar(
        title: Text('Meu primeiro Flutter '),
      ),
      body: Row(
        children: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              RestService().getter("/time/list");
            },
            child: Text('TextButton'),
          )
        ],
      ),
    );
  }
}
