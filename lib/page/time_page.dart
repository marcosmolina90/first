import 'package:first/model/jogador.dart';
import 'package:first/model/time.dart';
import 'package:first/page/app_page.dart';
import 'package:first/service/rest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:first/global.dart' as globals;
import '../components/menu_component.dart';

class TimePage extends StatefulWidget {
  const TimePage({Key? key}) : super(key: key);

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  List<Time> times = [];
  Time timeEdit = Time();
  List<Jogador> jogadores = [];
  String idJogagor = "";

  @override
  initState() {
    init();
  }

  init() async {
    List list = await RestService().list('/time/list', null);
    setState(() {
      times = list.map((e) => Time.fromJson(e)).toList();
    });

    carregaJogadores();
  }

  carregaJogadores() async {
    List list = await RestService().list('/jogador/list', null);
    setState(() {
      jogadores = list.map((e) => Jogador.fromJson(e)).toList();
      print(jogadores);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuComponente(),
      appBar: AppBar(
        title: Text('Time lista versão 1'),
      ),
      body: ListView(
          children: times
              .map((e) => Card(
                      child: ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.close),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.red), // <-- Button color
                      ),
                    ),
                    onTap: () async {
                      timeEdit = e;
                      await showDialog(
                          context: context, builder: (_) => dialogCadastro());
                    },
                    title: Text(e.nome.toString()),
                    subtitle: Text(e.id.toString()),
                  )))
              .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          timeEdit = Time();
          await showDialog(context: context, builder: (_) => dialogCadastro());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  dialogCadastro() {
    return Dialog(
      child: SizedBox(
          height: 300,
          width: 450,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                    keyboardType: TextInputType.text,
                    controller: TextEditingController(text: timeEdit.nome),
                    onChanged: (value) => {timeEdit.nome = value},
                    decoration: const InputDecoration(
                        labelText: 'Nome', border: OutlineInputBorder())),
                Container(height: 5),
                InputDecorator(
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        labelText: 'Jogador',
                        border: OutlineInputBorder()),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<Jogador?>(
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      hint: const Text('Jogador'),
                      isExpanded: true,
                      onChanged: (any) {
                        setState(() {
                          timeEdit.jogador = any;
                        });
                      },
                      items: composeListaJogador(),
                    ))),
                ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        if (timeEdit.id == null)
                          await RestService().save('time', timeEdit);
                        else {
                          await RestService().update('time', timeEdit);
                        }
                        Navigator.pop(context);
                        init();
                      } catch (e) {
                        alerta(context, e.toString());
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar'))
              ],
            ),
          )),
    );
  }

  void alerta(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Atenção'),
              content: Text(message),
            ),
        barrierDismissible: true);
  }

  List<DropdownMenuItem<Jogador?>> composeListaJogador() {
    if (jogadores == null) {
      return [];
    } else if (jogadores.isEmpty) {
      return [];
    } else {
      return jogadores
          .map<DropdownMenuItem<Jogador?>>((e) => DropdownMenuItem<Jogador?>(
              value: e, child: Text(e.nome.toString())))
          .toList();
    }
  }
}
