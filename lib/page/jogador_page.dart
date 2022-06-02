import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class JogadorPage extends StatefulWidget {
  const JogadorPage({Key? key}) : super(key: key);

  @override
  State<JogadorPage> createState() => _JogadorPageState();
}

class _JogadorPageState extends State<JogadorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(children: [
        Container(
          height: 20,
        ),
        const UserAccountsDrawerHeader(
          accountName: Text('usuario'),
          accountEmail: Text(''),
        ),
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: const Text('Jogador'),
          subtitle: const Text('Abrir Tela Jogador'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: const Text('Time'),
          subtitle: const Text('Abrir Tela Time'),
          onTap: () {},
        ),
      ])),
      appBar: AppBar(
        title: Text('Meu primeiro Flutter '),
      ),
      body: Text('Jogador'),
    );
  }
}
