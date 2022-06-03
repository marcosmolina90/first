import 'package:flutter/material.dart';

class MenuComponente extends StatelessWidget {
  const MenuComponente({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        onTap: () {
          Navigator.of(context).pushNamed("/jogador");
        },
      ),
      ListTile(
        leading: const Icon(Icons.color_lens),
        title: const Text('Time'),
        subtitle: const Text('Abrir Tela Time'),
        onTap: () {
          Navigator.of(context).pushNamed("/time");
        },
      ),
    ]));
  }
}
