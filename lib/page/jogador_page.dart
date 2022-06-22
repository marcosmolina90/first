import 'package:first/model/jogador.dart';
import 'package:first/model/time.dart';
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
  List<DropdownMenuItem<Jogador>> lista = [];
  List<Jogador> jogadores = [];
  Jogador jogador = Jogador();

  @override
  initState() {
    init();
  }

  init() async {
    carregaJogadores();
  }

  carregaJogadores() async {
    List list = await RestService().list('/jogador/list', null);
    setState(() {
      jogadores = list.map((e) => Jogador.fromJson(e)).toList();
      jogadores.add(Jogador());
      lista = jogadores
          .map<DropdownMenuItem<Jogador>>((e) => DropdownMenuItem<Jogador>(
              value: e,
              child: Text(e.nome == null ? 'Selecione' : e.nome.toString())))
          .toList();
    });
  }

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
            onPressed: () async {
              List<dynamic> a = await RestService().list("/time/list", null);
              List<Time> times = a.map((e) => Time.fromJson(e)).toList();
              print(times);
            },
            child: Text('TextButton'),
          ),
        ],
      ),
    );
  }
}
